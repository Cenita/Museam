<template>
  <div class="th_detail-con">
    <banner
      v-if="patchDetail.status==='200'"
      :navs="navs"
      :banner="patchDetail.data.img"
      :title="title"/>
    <bg>
      <div class="movie-detail" v-if="patchDetail.status==='200'">
        <div class="m-info clearfix">
          <div class="de-img">
            <img :src="patchDetail.data.img"/>
          </div>
          <div class="m-txt">
            <h2 class="m-title">{{patchDetail.data.title}}</h2>
            <p class="address">
              <Icon type="ios-location-outline" class="location"></Icon>
              {{patchDetail.data.address}}
            </p>
            <p class="m-time">
              <Icon type="ios-timer-outline" class="time"></Icon>
              {{patchDetail.data.start_time}} 到 {{patchDetail.data.end_time}}
            </p>
            <p class="intr">
              {{patchDetail.data.introduce}}
            </p>
          </div>
        </div>
        <div class="clip-con" v-if="patchDetail.data.content">
          <p class="title">临展内容</p>
          <div class="clip-box" style="font-size: 18px;" v-html="patchDetail.data.content"></div>
        </div>
      </div>
    </bg>
  </div>
</template>
<script type="text/ecmascript-6">
  import {Icon} from 'iview'
  import Banner from '@/base/banner'
  import Bg from '@/base/bg'
  import {getExhibit,getBanners} from "../../public/js/api";

  export default {

    components: {
      Icon,
      Banner,
      Bg
    },
    data() {
      return {
        patchDetail: '',
        title: '活动展览',
        navs: [
        ],
        banner:"",
      }
    },
    created() {
      this.getDetailData()
    },
    methods: {
      getDetailData() {
        var _this = this;
        getExhibit({id:parseInt(this.$route.query.id)}).then(res=>{
          _this.patchDetail = res;
        });
      }
    }
  }
</script>
<style scoped lang="less">
  .movie-detail {
    width: 1200px;
    margin: 0 auto;
    padding-top: 50px;
    padding-bottom: 60px;
    .m-info {
      .de-img{
        width: 450px;
        height: 320px;
        float: left;
        overflow: hidden;
        border: 8px solid #fff;
        -webkit-border-radius: 2px;
        -moz-border-radius: 2px;
        border-radius: 2px;
        box-shadow: 0 3px 36px 0 #EDEDED;
        img {
          width: 100%;
        }
      }
      .m-txt {
        float: left;
        margin-top: 40px;
        margin-left: 40px;
        width: 710px;
        text-align: justify;
        .m-title {
          font-size: 30px;
          color: #333;
          margin-bottom: 15px;
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
          }
        }
        .address {
          color: #ff3335;
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
          color: #596781;
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
          color: #596781;
          line-height: 28px;
          margin-top: 10px;
          margin-bottom: 30px;
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
      }
    }
    .movie-clips {
      padding-top: 80px;
      padding-bottom: 50px;
      .title {
        font-size: 25px;
        color: #333;
        margin-bottom: 20px;
      }
    }
    .clip-con{
      padding-top: 40px;
      padding-bottom: 40px;
      .title {
        font-size: 25px;
        color: #333;
        margin-bottom: 20px;
      }
      .clip-box{
        background: #fff;
        padding: 20px;
        border-radius: 4px;
      }
    }
  }
</style>
