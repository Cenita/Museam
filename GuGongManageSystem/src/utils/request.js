import axios from 'axios';
import {main} from '../main';

const service = axios.create({
    // process.env.NODE_ENV === 'development' 来判断是否开发环境
    baseURL: 'http://localhost:4269/api',
    timeout: 5000,
    withCredentials:true
})
service.defaults.withCredentials=true;
service.interceptors.request.use( config => {
    return config;
}, error => {
    console.log(error);
    return Promise.reject();
})

service.interceptors.response.use(response => {
    if(response.status === 200){
        if(response.data.status!=='200'){
            if(response.data.status==='402'){
                main.$message.error("该账户没有权限操作");
                main.$router.push('/login')
            }
            else if(response.data.status==='401'){
                main.$message.error("没有登录");
                main.$router.push('/login')
            }else{
                main.$message.error("错误："+response.data.interpret);
            }
        }
        return response.data;
    }else{
        main.$message.error("请求发生错误");
        Promise.reject();
    }
}, error => {
    console.log(error);
    return Promise.reject();
})

export default service;