package com.lite.api.controller.publics.auth;

import com.lite.auth.convert.UserConverter;
import com.lite.auth.exception.AuthException;
import com.lite.auth.exception.UserNotFoundException;
import com.lite.auth.service.AuthService;
import com.lite.auth.vo.UserVo;
import com.lite.common.dto.ResultResponse;
import com.lite.common.dto.token.JwtTokenWrapper;
import com.lite.common.groups.NormalGroups;
import com.lite.common.i18n.SystemMessages;
import com.lite.common.utils.ResultResponseUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@RestController
@Slf4j
@RequestMapping("/auth")
@Validated
public class AuthController {

    @Autowired
    AuthService service;

    @Autowired
    UserConverter userConverter;

    /**
     * 用户登陆接口
     *
     * @param mail     用户邮箱
     * @param password 密码
     * @return JwtTokenWrapper 登陆成功后返回的Token
     * @throws AuthException
     */
    @GetMapping("/login")
    public ResultResponse<JwtTokenWrapper> login(
            @RequestParam @Email @NotBlank String mail,
            @RequestParam @NotBlank String password)
            throws AuthException {

        return ResultResponseUtils.success(
                service.login(mail, password),
                SystemMessages.get("success.user.auth.login"));
    }

    /**
     * 用户注册接口
     *
     * @param userVo 用户视图层对象
     * @return 是否成功注册
     * @throws AuthException
     */
    @PostMapping("/register")
    public ResultResponse<Boolean> register(
            @Validated(NormalGroups.Crud.Insert.class) @RequestBody UserVo userVo)
            throws AuthException {


        return service.register(userConverter.voToNormalDto(userVo)) ?
                ResultResponseUtils.success(true, SystemMessages.get("success.user.auth.register")) :
                ResultResponseUtils.error(false, SystemMessages.get("error.user.auth.register"));
    }

    /**
     * 更新一个用户的信息
     *
     * @param userVo 用户视图层对象
     * @return 是否成功更新
     * @throws AuthException
     */
    @PostMapping("/updateInfo")
    public ResultResponse<Boolean> updateInfo(@RequestBody UserVo userVo) throws AuthException {
        return service.updateUserInfo(userVo) ?
                ResultResponseUtils.success(true, SystemMessages.get("success.user.auth.update")) :
                ResultResponseUtils.error(false, SystemMessages.get("error.user.auth.update"));
    }

    /**
     * 修改用户密码
     *
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @return 是否修改成功
     * @throws AuthException
     */
    @PostMapping("/changePassword")
    public ResultResponse<Boolean> changePassword(
            @RequestParam @NotBlank String oldPassword,
            @RequestParam @NotBlank String newPassword)
            throws AuthException {

        return service.changePassword(oldPassword, newPassword) ?
                ResultResponseUtils.success(true, SystemMessages.get("success.user.auth.passwordChange")) :
                ResultResponseUtils.error(false, SystemMessages.get("error.user.auth.passwordChange"));
    }

    /**
     * 忘记密码接口
     *
     * @param mail        邮箱
     * @param newPassword 新密码
     * @param code        验证码
     * @return 是否修改成功
     * @throws AuthException
     */
    @PostMapping("/forgetPassword")
    public ResultResponse<Boolean> forgetPassword(
            @RequestParam @Email @NotBlank String mail,
            @RequestParam @NotBlank String newPassword,
            @RequestParam @NotBlank String code) throws AuthException {

        return service.forgetPassword(mail, newPassword, code) ?
                ResultResponseUtils.success(true, SystemMessages.get("success.user.auth.passwordChange")) :
                ResultResponseUtils.error(false, SystemMessages.get("error.user.auth.passwordChange"));
    }

    /**
     * 登出接口
     *
     * @return 是否登出成功
     */
    @PostMapping("/logout")
    public ResultResponse<Boolean> logout() {

        return service.logout() ?
                ResultResponseUtils.success(true, SystemMessages.get("success.user.auth.logout")) :
                ResultResponseUtils.error(false, SystemMessages.get("error.user.auth.logout"));
    }

    /**
     * 刷新Token
     *
     * @return 新的Token
     * @throws UserNotFoundException
     */
    @GetMapping("/refreshToken")
    public ResultResponse<JwtTokenWrapper> refreshToken()
            throws UserNotFoundException {

        return ResultResponseUtils.success(
                service.refreshToken(),
                SystemMessages.get("success.jwt.access.refresh")
        );
    }

}
