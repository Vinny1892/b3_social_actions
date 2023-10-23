import HomeView from '@/views/HomeView.vue';
import ForbiddenView from '@/views/ForbiddenView.vue';
import ListSocialActionView from '@/views/socialAction/listPublicSocialAction/ListSocialActionView.vue';
import DetailsSocialActionView
  from '@/views/socialAction/detailsSocialAction/DetailsSocialActionView.vue';
import CreateSocialAction from '@/views/socialAction/createSocialAction/CreateSocialActionView.vue';
import UpdateSocialActionView from '@/views/socialAction/updateSocialAction/UpdateSocialActionView.vue';
import ListPrivateSocialAction
  from '@/views/socialAction/listPrivateSocialAction/ListPrivateSocialAction.vue';
import CreateTaskView from '@/views/task/createTask/CreateTaskView.vue';
import RegisterPresenceView from '@/views/presence/RegisterPresenceView/RegisterPresenceView.vue';

// eslint-disable-next-line import/prefer-default-export
export const routes = [
  {
    path: '/',
    redirect: (to) => '/social-action/public',
  },
  {
    path: '/task/:id/credenciar',
    name: 'RegisterPresence',
    component: RegisterPresenceView,
    meta: { auth: true },
  },
  {
    path: '/task/create',
    name: 'CreateTaskView',
    component: CreateTaskView,
    meta: {
      auth: true,
    },
  },
  {
    path: '/social-action/public',
    name: 'ListPublicSocialActionView',
    component: ListSocialActionView,
    meta: {
      auth: false,
    },
  },
  {
    path: '/social-action/private',
    name: 'ListPrivateSocialActionView',
    component: ListPrivateSocialAction,
    meta: {
      auth: true,
    },
  },
  {
    path: '/social-action/edit/:id',
    name: 'UpdateSocialActionView',
    component: UpdateSocialActionView,
    meta: {
      auth: true,
    },
  },
  {
    path: '/social-action/create',
    name: 'CreateSocialActionView',
    component: CreateSocialAction,
    meta: {
      auth: true,
    },
  },
  {
    path: '/social-action/:id',
    name: 'DetailSocialActionView',
    component: DetailsSocialActionView,
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
