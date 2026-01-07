<template>
  <div class="navs flex align-center">
    <div
      class="navs-item"
      v-for="nav in navs"
      :key="nav.name">
      <span
        class="link"
        :class="{ active: $route.path === nav.path }"
        @click="$router.push(nav.path)"
        >{{ nav.name }}</span
      >
    </div>
  </div>
</template>

<script setup>
  const navs = [
    {
      name: '首页',
      path: '/layout',
    },
    {
      name: '航班信息',
      path: '/company',
    },
    {
      name: '民航新闻',
      path: '/news',
    },
    {
      name: '个人中心',
      path: '/center',
    },
  ];
</script>

<style lang="scss" scoped>
  .navs {
    position: fixed;
    top: 65px;
    left: 0;
    z-index: 999;
    width: 100%;
    height: 60px;
    padding: 10px 4vw;
    background-color: #fff;
    border-bottom: 1px solid #eee;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);

    .navs-item {
      margin-right: 30px;

      .link {
        position: relative;
        color: #4169e1;
        font-size: 16px;
        text-decoration: none;
        letter-spacing: 0.1em;
        font-weight: 600;
        cursor: pointer;

        &::after {
          content: '';
          display: none;
          position: absolute;
          left: 0;
          bottom: -70%;
          width: 0;
          height: 2px;
          border-radius: 20px;
          transition: width 0.5s ease;
          background-color: #0000cd;
          box-shadow: 0 4px 20px 2px rgba(0, 0, 205, 0.2);
        }

        &:hover {
          color: #0000cd;
        }
      }

      .active {
        color: #0000cd;

        & {
          &::after {
            display: block;
            width: 100%;
          }
        }
      }
    }
  }
</style>
