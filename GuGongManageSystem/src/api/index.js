import request from '../utils/request';

export const getBanner = (query) => {
    return request({
        url: '/home_banner',
        method: 'GET',
        data: query
    })
}
export const setBanner = (query) => {
    return request({
        url: '/home_banner/'+query.id,
        method: 'PUT',
        data: query
    })
}
export const addBanner = (query) => {
    return request({
        url: '/home_banner/',
        method: 'POST',
        data: query
    })
}
export const deleteBanner = (query) => {
    return request({
        url: '/home_banner/'+query.id,
        method: 'DELETE',
        data: query
    })
}
export const getUser = (query) => {
    return request({
        url: '/users/UserManage',
        method: 'GET',
        data: query
    })
}
export const getSuccincts = (query) => {
    return request({
        url: '/succincts',
        method: 'GET',
        data: query
    })
}
export const setSuccincts = (query) => {
    return request({
        url: '/succincts/'+query.id,
        method: 'PUT',
        data: query
    })
}
export const addSuccincts = (query) => {
    return request({
        url: '/succincts',
        method: 'POST',
        data: query
    })
}
export const deleteSuccincts = (query) => {
    return request({
        url: '/succincts/'+query.id,
        method: 'DELETE',
        data: query
    })
}
export const getCollections = (query) => {
    return request({
        url: '/collections',
        method: 'GET',
        params: query
    })
}
export const setCollections = (query) => {
    return request({
        url: '/collections/'+query.id,
        method: 'PUT',
        data: query
    })
}
export const deleteCollections = (query) => {
    return request({
        url: '/collections/'+query.id,
        method: 'DELETE',
        data: query
    })
}
export const addCollections = (query) => {
    return request({
        url: '/collections',
        method: 'POST',
        data: query
    })
}
export const getExhibit = (query) => {
    return request({
        url: '/exhibits',
        method: 'GET',
        params: query
    })
}
export const getExhibitPeople = (query) => {
    return request({
        url: '/exhibits/GetReverList',
        method: 'GET',
        params:query
    })
}
export const setExhibit = (query) => {
    return request({
        url: '/exhibits/'+query.id,
        method: 'PUT',
        data: query
    })
}
export const addExhibit = (query) => {
    return request({
        url: '/exhibits',
        method: 'POST',
        data: query
    })
}
export const deleteExhibit = (query) => {
    return request({
        url: '/exhibits/'+query.id,
        method: 'DELETE',
        data: query
    })
}
export const getQuestion = (query) => {
    return request({
        url: '/questions/GetTypeQuesiton',
        method: 'GET',
        data: query
    })
}
export const getTicket = (query) => {
    return request({
        url: '/appointments/AppManage?selectTime='+query.selectTime,
        method: 'GET',
    })
}
export const deleteTicket = (query) => {
    return request({
        url: '/appointments/'+query.id,
        method: 'DELETE',
        data: query
    })
}
export const setQuestion = (query) => {
    return request({
        url: '/questions/'+query.id,
        method: 'PUT',
        data: query
    })
}
export const deleteQuestion = (query) => {
    return request({
        url: '/questions/'+query.id,
        method: 'DELETE',
        data: query
    })
}
export const setUsers = (query) => {
    return request({
        url: '/users/Putusers/'+query.id,
        method: 'PUT',
        data: query
    })
}
export const deleteUsers = (query) => {
    return request({
        url: '/users/Deleteusers/'+query.id,
        method: 'DELETE',
        data: query
    })
}
export const login = (query) => {
    return request({
        url:'/users/Login',
        method:'POST',
        data:query
    })
};

export const loginOut = (query) => {
    return request({
        url:'/api/users/LoginOut',
        method:'POST',
    })
}
export const getConfig = (query) => {
    return request({
        url:'/home/getBaseConfig',
        method:'GET',
    })
}
export const setConfig = (query) => {
    return request({
        url:'/home/'+query.id,
        method:'PUT',
        data:query
    })
}
