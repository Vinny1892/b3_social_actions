import Vue from 'vue';
import VueRouter from 'vue-router';
import Keycloak, { keycloakInit } from '@/plugins/keycloak';
import { routes } from '@/router/routes';

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

function verifyHasPermission(keycloak, to, next) {
  if (to.meta.role !== undefined && !keycloak.hasRealmRole(to.meta.role)) {
    next({ name: 'ForbiddenView' });
  }
}

router.beforeEach(async (to, from, next) => {
  const keycloak = Keycloak();

  if (!keycloak.didInitialize) {
    await keycloakInit(keycloak);
  }
  const userIsAuthenticated = keycloak.authenticated;
  if (to.meta.auth === true && !userIsAuthenticated) {
    await keycloak.login();
  } else {
    verifyHasPermission(keycloak, to, next);
  }

  if (keycloak.token !== undefined) {
    sessionStorage.setItem('token', keycloak.token);
  }
  next();
});

export default router;
