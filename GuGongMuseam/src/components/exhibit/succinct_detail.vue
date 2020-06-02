<template>
  <div class="su_detail-con">
    <banner
      :navs="navs"
      :banner="banner"
      :title="title"
      @handleClick="getBanner"/>
    <bg>

      <div class="ty_detail">
        <i class="el-icon-arrow-left" @click="$router.back(-1)" style="font-size: 40px;color: #ff413f;position: absolute;"></i>
        <p class="title">{{content.title}}<span></span></p>
        <div style="text-align: center;margin: auto;">
          <img v-lazy="content.img" alt="">
        </div>
        <div style="margin-top: 20px;font-size: 15px;" class="art" v-html="content.introduce">
        </div>
      </div>
    </bg>
  </div>
</template>
<script type="text/ecmascript-6">
  import Banner from '@/base/banner'
  import Bg from '@/base/bg'
  import {getCollection,getBanners} from "../../public/js/api";

  export default {

    components: {
      Banner,
      Bg
    },
    data() {
      return {
        navs: [

        ],
        title: '藏品展示',
        content: '',
        banner:""
      }
    },
    created() {
      this.getBanner()
      this.getArticleText()
    },
    methods: {
      /**
       * 获取藏品精粹banner
       * @param id  分类id
       */
      getBanner() {
        var _this = this;
        getBanners({name:"藏品细节"}).then(res=>{
          _this.banner = res.data.img;
        })
      },
      getArticleText() {
        var _this = this;
        getCollection({id:parseInt(this.$route.query.id)}).then(res=>{
          _this.content = res.data;
        })
      }
    }
  }
</script>
<style lang="less">
  .ty_detail {
    padding-top: 50px;
    width: 1200px;
    margin: 0 auto;
    padding-bottom: 60px;
    .art{
      background: #fff;
      padding: 20px 30px;
      border-radius: 4px;
      width: 900px;
      margin: 0 auto;
      box-shadow: 0 3px 36px 0 #EDEDED;
      p{
        background: none !important;
      }
      span{
        background: none !important;
      }
    }
    .title {
      font-size: 22px;
      color: #666;
      text-align: center;
      margin-bottom: 50px;
      letter-spacing: 2px;
      span {
        width: 90px;
        height: 4px;
        display: block;
        margin: 10px auto;
        background-image: -webkit-linear-gradient(135deg, #ff7d7f, #ff413f);
        background-image: -moz-linear-gradient(135deg, #ff7d7f, #ff413f);
        background-image: -o-linear-gradient(135deg, #ff7d7f, #ff413f);
        background-image: -ms-linear-gradient(135deg, #ff7d7f, #ff413f);
        background-image: linear-gradient(135deg, #ff7d7f, #ff413f);
        -webkit-border-radius: 10px;
        -moz-border-radius: 10px;
        border-radius: 10px;
      }
    }
  }
</style>
