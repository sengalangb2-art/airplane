import { ref, computed } from "vue";
import router from "@/router";
import { defineStore } from "pinia";
import {
  removeToken,
  removeUser,
  setToken,
  setUser,
  getUser,
} from "@/utils/cookie.js";

export const useUserStore = defineStore(
  "user",
  () => {
    const token = ref(getToken());
    const userInfo = ref(getUser());

    const isLoggedIn = computed(() => {
      return token.value !== null;
    });

    const SET_TOKEN = (tokens) => {
      token.value = tokens;
      setToken(tokens);
    };

    const SET_USER_INFO = (user) => {
      userInfo.value = user;
      setUser(user);
    };

    const LOGOUT = () => {
      token.value = null;
      userInfo.value = null;
      removeToken();
      removeUser();
      router.replace("/login");
    };

    return {
      token,
      userInfo,
      isLoggedIn,
      SET_TOKEN,
      SET_USER_INFO,
      LOGOUT,
    };
  },
  {
    persist: true,
  }
);
