<template>
  <!--展览列表的Item-->
  <div class="m-item clearfix">
    <router-link :to="{path:'/patch/patch-detail',query:{id:data.id}}" class="course-img">
      <img v-lazy="data.img"/>
    </router-link>
    <div class="m-txt">
      <h2 class="m-title">
        <router-link :to="{path:'/patch/patch-detail',query:{id:data.id}}">{{data.title}}</router-link>
      </h2>
      <p class="m-time">
        <Icon type="ios-calendar-outline" class="time"></Icon>
        {{data.start_time}} 至 {{data.end_time}}
      </p>
      <p class="address">
        <Icon type="ios-location-outline" class="location"></Icon>
        {{data.address}}
      </p>
      <p class="intr">
        {{data.introduce}}
      </p>
      <div class="keywords" v-if="data.courseclass">
        <span v-for="(item,index) in data.courseclass" :key="index">
          {{item}}
        </span>
      </div>
      <div class="order" v-if="(this.data.type===4||this.data.type===2)&&this.$store.state.islogin">
        <input type="button" v-if="status" class="input-btn" value="预约" @click="orderExhibit">
        <input type="button" v-else class="input-cancel" value="取消预约" @click="disorderExhibit">
      </div>
      <!--<p class="btn-book">立即预定</p>-->
    </div>
  </div>
</template>
<script type="text/ecmascript-6">
  import {Icon} from 'iview'
  import {postReservation,deleteReservation} from "../../public/js/api";

  export default {
    props: {
      patch_data: {
        default: ''
      },
      type: 0,
    },
    methods:{
      orderExhibit(){
        var data = {
          "exhibit_id":this.data.id,
        }
        var _this = this;
        postReservation(data).then(res=>{
          if(res.status==="200"){
            _this.status=false;
            _this.detail=res.data;
            _this.$message.success('预约成功')
            _this.$emit('reflush');
          }
        })
      },disorderExhibit(){
        var _this = this;
        deleteReservation(this.detail.id).then(res=>{
          if(res.status==="200"){
            _this.status=true;
            _this.$message.success('取消预约成功');
            _this.$emit('reflush');
          }
        })
      },fuzhi(){
        if(this.type==4){
          this.data = this.patch_data.data;
        }else{
          this.data = this.patch_data;
        }
        this.status = this.data.is_reservation==null;
        this.detail = this.data.is_reservation;
      }
    },created(){
      this.fuzhi();
    },
    watch:{
      patch_data:function () {
        this.fuzhi();
      }
    }
    ,
    components: {
      Icon,
    },
    data() {
      return {
        data:"",
        status:"",
        detail:""
      }
    }
  }
</script>
<style scoped lang="less">
  .order{
    .input-btn {
      margin-top: 40px;
      width: 100%;
      display: block;
      border: none;
      height: 44px;
      line-height: 44px;
      background-color: #3c97ee;
      background-image: linear-gradient(90deg, #00d0fb, #00acf6);
      color: #fff;
      overflow: hidden;
      cursor: pointer;
      font-size: 14px;
      text-align: center;
      -webkit-border-radius: 4px;
      -moz-border-radius: 4px;
      border-radius: 4px;
    }
    .input-cancel{
      margin-top: 40px;
      width: 100%;
      display: block;
      border: none;
      height: 44px;
      line-height: 44px;
      background-color: #ff413f;
      background-image: linear-gradient(90deg, #b93127, #ff3335);
      color: #fff;
      overflow: hidden;
      cursor: pointer;
      font-size: 14px;
      text-align: center;
      -webkit-border-radius: 4px;
      -moz-border-radius: 4px;
      border-radius: 4px;
    }
  }
  .m-item {
    margin-bottom: 25px;
    background: #fff;
    box-shadow: 0 3px 36px 0 #EDEDED;
    .course-img{
      width: 450px;
      float: left;
      height: 320px;
      line-height: 200px;
      text-align: center;
      overflow: hidden;
      img{
        width: 100%;
        height: 100%;
      }
    }
    .m-txt {
      float: left;
      margin-top: 20px;
      margin-left: 40px;
      width: 700px;
      text-align: justify;
      .m-title {
        font-size: 28px;
        color: #333;
        margin-bottom: 15px;
        a {
          color: #333;
          &:hover {
            color: #d72c27;
          }
        }
        .mold {
          font-size: 14px;
          background-image: -webkit-linear-gradient(135deg, #00d0fb, #00acf6);
          background-image: -moz-linear-gradient(135deg, #00d0fb, #00acf6);
          background-image: -o-linear-gradient(135deg, #00d0fb, #00acf6);
          background-image: -ms-linear-gradient(135deg, #00d0fb, #00acf6);
          background-image: linear-gradient(135deg, #00d0fb, #00acf6);
          width: 46px;
          height: 25px;
          margin-left: 10px;
          display: inline-block;
          -webkit-border-radius: 2px;
          -moz-border-radius: 2px;
          border-radius: 2px;
          vertical-align: middle;
          text-align: center;
          line-height: 25px;
          color: #fff;
        }
      }
      .address {
        color: #d72c27;
        font-size: 16px;
        margin-bottom: 10px;
        .location {
          width: 18px;
          font-size: 20px;
          font-weight: bold;
          margin-right: 5px;
        }
      }
      .m-time {
        color: #5e6d84;
        font-size: 16px;
        margin-bottom: 10px;
        .time {
          width: 18px;
          font-size: 20px;
          font-weight: bold;
          margin-right: 5px;
        }
      }
      .intr {
        font-size: 16px;
        color: #9a9a9a;
        line-height: 28px;
        margin-top: 10px;
        margin-bottom: 20px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
      }
      .btn-book {
        width: 130px;
        height: 45px;
        background-image: -webkit-linear-gradient(135deg, #00d0fb, #00acf6);
        background-image: -moz-linear-gradient(135deg, #00d0fb, #00acf6);
        background-image: -o-linear-gradient(135deg, #00d0fb, #00acf6);
        background-image: -ms-linear-gradient(135deg, #00d0fb, #00acf6);
        background-image: linear-gradient(135deg, #00d0fb, #00acf6);
        text-align: center;
        line-height: 45px;
        -webkit-border-radius: 2px;
        -moz-border-radius: 2px;
        border-radius: 2px;
        font-size: 16px;
        color: #fff;
        cursor: pointer;
      }
      .keywords {
        color: #a3a3a3;
        display: inline-block;
        span {
          display: inline-block;
          margin-right: 10px;
          padding: 10px 20px;
          background: #f0f0f0;
          -webkit-border-radius: 4px;
          -moz-border-radius: 4px;
          border-radius: 4px;
        }
      }
    }
  }
</style>
