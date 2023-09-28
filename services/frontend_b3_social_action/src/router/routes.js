import HomeView from '@/views/HomeView.vue';
import ForbiddenView from '@/views/ForbiddenView.vue';

// eslint-disable-next-line import/prefer-default-export
export const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
    meta: {
      auth: false,
    },
  },
  {
    path: '/forbidden',
    name: 'ForbiddenView',
    meta: {
      auth: false,
    },
    component: ForbiddenView,
  },
  {
    path: '/about',
    name: 'about',
    meta: {
      auth: true,
      role: 'CREATE_SOCIAL_ACTION',
    },
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue'),
  },
];
