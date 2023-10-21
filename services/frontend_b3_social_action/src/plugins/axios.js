/* eslint-disable dot-notation */
import axios, { AxiosRequestConfig } from 'axios';

const baseURL = process.env.VUE_APP_BASE_ROOT_API || 'http://localhost:32256';
const api = axios.create({
  baseURL,
  headers: {
    'Access-Control-Allow-Origin': '*',
  },
});

export function isAxiosError(error) {
  return axios.isAxiosError(error);
}

export default api;
