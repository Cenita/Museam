import request from './config'
export const getSuccincts = (query) => {
  return request({
    url:'/api/succincts',
    method:'GET',
    data:query
  })
};
export const getExhibits = (query) => {
  return request({
    url:'/api/exhibits',
    method:'GET',
    params:{address:query.type}
  })
};
export const getSuccinct = (query) => {
  return request({
    url:'/api/succincts/'+query.id,
    method:'GET',
  })
};
export const getCollection = (query) => {
  return request({
    url:'/api/collections/'+query.id,
    method:'GET',
  })
};
export const getExhibit = (query) => {
  return request({
    url:'/api/exhibits/'+query.id,
    method:'GET',
  })
};
export const getBanners = (query) => {
  return request({
    url:'/api/banners/'+query.name,
    method:'GET',
  })
};
export const getQuestions = (query) => {
  return request({
    url:'/api/questions/',
    method:'GET',
  })
};
export const getHomeData = (query) => {
  return request({
    url:'/api/home/',
    method:'GET',
  })
};
export const getViewNumber = (query) => {
  return request({
    url:'/api/home/getViewNumber',
    method:'GET',
  })
};
export const register = (query) => {
  return request({
    url:'/api/users/Register',
    method:'POST',
    data:query
  })
};
export const login = (query) => {
  return request({
    url:'/api/users/Login',
    method:'POST',
    data:query
  })
};
export const getStatus = (query) => {
  return request({
    url:'/api/status',
    method:'GET',
  })
}
export const loginOut = (query) => {
  return request({
    url:'/api/users/LoginOut',
    method:'POST',
  })
}
export const getUserAsk = (query) => {
  return request({
    url:'/api/questions/getUserAsk',
    method:'GET',
  })
}
export const addQuestion = (query) => {
  return request({
    url:'/api/questions/addQuestion',
    method:'POST',
    data:query
  })
}
export const getTicket = (query) => {
  return request({
    url:'/api/appointments',
    method:'GET',
    data:query
  })
}
export const addTicket = (query) => {
  return request({
    url:'/api/appointments',
    method:'POST',
    data:query
  })
}
export const deleteTicket = (query) => {
  return request({
    url:'/api/appointments/'+query.id,
    method:'delete',
    data:query
  })
}
export const postReservation = (query) => {
  return request({
    url:'/api/exhibit_reservation',
    method:'POST',
    data:query
  })
}
export const deleteReservation = (query) => {
  return request({
    url:'/api/exhibit_reservation/'+query,
    method:'DELETE',
  })
}

