package com.bsuir.CourseWork.service;

import com.bsuir.CourseWork.Domain.Request;
import com.bsuir.CourseWork.Domain.Role;
import com.bsuir.CourseWork.Domain.User;
import com.bsuir.CourseWork.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.commons.lang3.RandomStringUtils;

import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
public class UserService implements UserDetailsService {
    @Autowired
    MailService mailService;
    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username);
    }

    public void NotifyUserAboutClose(User user, Request request) {

        String messageOnEmail = String.format(
                "Здравствуйте, " + request.getUserApplicant().getFio() + "!\n" + "Ваша задача под номером: " + request.getId() + " была выполнена.\n" +
                        "Системный администратор выполнявший работу: " + user.getFio() + "\n" +
                        "Телефон для связи (мобильный): " + user.getTelephoneMobile() +"\n"+
                        "Телефон городской: "+user.getTelephoneWork());

        mailService.send(request.getUserApplicant().getUsername(), "Выполнение заявки", messageOnEmail);
    }

    public User userBySecurityContext() {
        User user = new User();
        try {
            user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            return user;
        } catch (NullPointerException ex) {
            return user;
        }
    }


    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public List<User> findUserByFio(String fio) {
        return userRepository.findAllByFioContaining(fio);
    }

    public String addNewUser(User user, String role) {
        String message = "Пользователь был создан!";

        // String password = RandomStringUtils.random(32, 0, 20, true, true, "qw32rfHIJk9iQ8Ud7h0X".toCharArray());
        User userFromDb = userRepository.findByUsername(user.getUsername());
        if (userFromDb != null) {
            return "Пользователь с таким логином уже существует!";
        } else {
            String password = RandomStringUtils.random(7, 0, 20, true, true, "qw32rfHIJk9iQ8Ud7h0X".toCharArray());

            String encryptPassword = passwordEncoder.encode(password);

            user.setPassword(encryptPassword);
            user.setActive(true);
            user.setRoles(Collections.singleton(Role.valueOf(role)));
            userRepository.save(user);


            String messageOnEmail = String.format(
                    "Здравствуйте " + user.getFio() + "!\n" + "Вам была создана учетная запись на предприятии Белелектромонтажналадка.\n" +
                            "Ваш логин: " + user.getUsername() + "\n" + "Ваш пароль: " + password);

            mailService.send(user.getUsername(), "Создание учетной записи", messageOnEmail);

        }
        return message;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();

    }

    public User findUserById(Long id) {
        return userRepository.findUserById(id);
    }

    public void editUserRole(String role, Long id) {
        User user = userRepository.findUserById(id);

        user.getRoles().clear();
        user.getRoles().add(Role.valueOf(role));
        userRepository.save(user);
    }

    public void rememberPassword(String email) {
        User user = userRepository.findByUsername(email);
        user.setActivationCode(UUID.randomUUID().toString());

        String message = String.format(
                "Hello, %s! \n" + "You requested a password reset? \n" +
                        " Please, visit next link: http://localhost:8080/restore/%s",
                user.getUsername(),
                user.getActivationCode());

        mailService.send(user.getUsername(), "Activation code", message);
    }

    public User findUserByActivationCode(String activationCode) {
        return userRepository.findUserByActivationCode(activationCode);
    }

    public void createNewPassword(User user, String password) {

        String encryptPassword = passwordEncoder.encode(password);
        user.setPassword(password);

        user.setPassword(encryptPassword);
        user.setActivationCode(null);
        userRepository.save(user);
    }

    public User findUserByUserName(String username) {
        return userRepository.findByUsername(username);
    }

    public User findOneUserByFIO(String fio) {
        try {
            return userRepository.findUserByFio(fio);
        } catch (NullPointerException ex) {
            User user = new User();
            return user;
        }
    }

    public void deleteUser(User user) {
        userRepository.delete(user);
    }

    public List<User> findAllAdmin() {
        List<User> userList = userRepository.findAll();
        List<User> users = userList.stream().filter(us -> us.getRoles().iterator().next().name().equals("ADMIN") ||
                us.getRoles().iterator().next().name().equals("SUPER_ADMIN")).collect(Collectors.toList());
        return users;
    }
}
