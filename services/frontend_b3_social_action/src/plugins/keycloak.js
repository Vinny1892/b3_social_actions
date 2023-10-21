import Keycloak from 'keycloak-js';

const initOptions = {
  url: 'http://localhost:8084',
  clientId: 'frontend_b3_social_action',
  realm: 'b3_social',
};
const keycloak = new Keycloak(initOptions);

// eslint-disable-next-line no-shadow
export const keycloakInit = async (keycloak) => {
  await keycloak.init({ onload: 'login-required' });
};

export default function () {
  return keycloak;
}
