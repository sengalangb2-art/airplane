import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/layout',
    },
    {
      path: '/layout',
      name: 'Layout',
      component: () => import('@/layout/index.vue'),
      children: [
        {
          path: '',
          name: 'Home',
          component: () => import('@/views/home/index.vue'),
        },
        {
          path: '/position',
          name: 'Position',
          component: () => import('@/views/position/index.vue'),
        },
        {
          path: '/notice',
          name: 'Notice',
          component: () => import('@/views/notice/index.vue'),
        },
        {
          path: '/company',
          name: 'Company',
          component: () => import('@/views/company/index.vue'),
        },
        {
          path: '/news',
          name: 'News',
          component: () => import('@/views/news/index.vue'),
        },
        {
          path: '/center',
          name: 'Center',
          component: () => import('@/views/center/index.vue'),
        },
      ],
    },
    {
      path: '/login',
      name: 'Login',
      component: () => import('@/views/login/index.vue'),
    },
    {
      path: '/register',
      name: 'Register',
      component: () => import('@/views/register/index.vue'),
    },
  ],
});

export default router;
