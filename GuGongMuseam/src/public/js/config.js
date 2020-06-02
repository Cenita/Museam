import axios from 'axios';
import {main} from '../../main'
const service = axios.create({
  // process.env.NODE_ENV === 'development' 来判断是否开发环境
  baseURL: "http://localhost:4269",
  timeout: 2000
});
service.defaults.withCredentials=true;
service.interceptors.request.use( config => {
  const token = main.$store.state.Authorization;
  if (token) {
    config.headers['Authorization'] = token;
  }
  return config;
}, error => {
  console.log(error);
  return Promise.reject();
});

service.interceptors.response.use(response => {
  if(response.status===200)
  {
    return response.data;
  }
}, error => {
  console.log(error);
  return Promise.reject();
});
export default service;
