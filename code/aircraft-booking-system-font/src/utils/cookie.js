import Cookie from 'js-cookie';

const CookieKey = {
  TOKEN: 'TOKEN_KEY',
  USER: 'USER_KEY',
};

// 设置token cookie
export function setToken(token) {
  return Cookie.set(CookieKey.TOKEN, token);
}

// 获取token cookie
export function getToken() {
  return Cookie.get(CookieKey.TOKEN);
}

// 删除token cookie
export function removeToken() {
  return Cookie.remove(CookieKey.TOKEN);
}

// 设置用户信息 cookie
export function setUser(info) {
  const item = JSON.stringify(info);
  return Cookie.set(CookieKey.USER, item);
}

// 获取用户信息 cookie
export function getUser() {
  return Cookie.get(CookieKey.USER)
    ? JSON.parse(Cookie.get(CookieKey.USER))
    : null;
}

// 删除用户信息 cookie
export function removeUser() {
  return Cookie.remove(CookieKey.USER);
}
