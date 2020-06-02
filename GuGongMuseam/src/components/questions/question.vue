<template>
  <div class="question">
    <banner
      :navs="navs"
      :banner="banner"
      :title="title"
      @handleClick="getBanner"/>
    <bg>
      <div class="qu-con clearfix">
        <div class="answers-box">
          <div class="answers">
            <div class="search clearfix">
              <span class="ico" @click="searchKeyword()">
              </span>
            </div>
            <ul class="answers-list clearfix">
              <li class="clearfix" v-for="(item,index) in langList.data" :key="index">
                <p class="date">
                  <span class="day">{{item.addtime.slice(-2)}}</span>
                  <span class="month">{{item.addtime.slice(0, -3)}}</span>
                </p>
                <div class="answers-item">
                  <p class="q">Q：{{item.content}}？<span>{{item.type}}</span></p>
                  <p class="a">
                    A：{{item.reply}}
                  </p>
                </div>
              </li>
            </ul>
            <div class="data" style="margin-top: 40px">
              <no-data v-if="!langList.data"></no-data>
            </div>
          </div>
          <Pagination
            v-if="langList.total"
            :total="langList.total*10"
            :page="langList.currentpage"
            @handleChange="handlePage">
          </Pagination>
        </div>
        <div class="hlogin" v-if="this.$store.state.islogin">
          <div class="answers-box ask-box">
            <div class="answers">
              <div class="title">
                我想提问
              </div>
              <div class="ask-input">
                <textarea v-model="ask_text" name="" id="" cols="30" rows="10"></textarea>
                <input type="button" value="提交问题" @click="askQuestion">
              </div>
            </div>
          </div>
          <div class="answers-box ask-box" style="margin-top: 20px;">
            <div class="answers">
              <div class="title" style="color: darkred;">
                收到的回答
              </div>
              <div class="answers-myself">
                <div class="answers-item" v-for="(item,index) in ask_data" :key="index" >
                  <div class="index">
                  </div>
                  <div class="quesiton" style="color: #a29dad">
                    问 ：{{item.question}}
                  </div>
                  <div class="answer" style="color: #403d39" >
                    {{item.answer == null ? "等待回答..." : "答 ："+item.answer}}
                  </div>
                  <div class="time" style="color:#90a095">
                    {{item.addtime}}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </bg>
  </div>
</template>
<script type="text/ecmascript-6">
  import Banner from '@/base/banner'
  import Bg from '@/base/bg'
  import Pagination from '@/base/pagination'
  import NoData from '@/base/no-data'
  import NoLogin from '@/base/no-login'
  import {getQuestions,getBanners,getUserAsk,addQuestion} from "../../public/js/api";

  export default {

    components: {
      Banner,
      Bg,
      Pagination,
      NoData,
      NoLogin
    },
    data() {
      return {
        navs: [

        ],
        ask_text:"",
        ask_data:[],
        typeList: [],
        title: '咨询问答',
        current: 0,
        id: 1,
        content: {
          value: '',
          error: '',
          isVerify: false
        }, //文本框内容
        imgCode: {
          value: '',
          error: '',
          isVerify: false
        },
        page: 1, //页码
        searchVal: '',  //搜索内容
        langList: ["Asfasf","asfasf"], //留言列表
        icon: '../static/images/loading.png',
        token: false,
        banner:""
      }
    },
    created() {
      this.getBanner()
      this.getLangLists()
      this._token()
      this.getUserList();
    },
    methods: {
      /**
       * 获取咨询问答banner
       * @param id  分类id
       */
      getBanner() {
        var _this = this;
        getBanners({name:"咨询问答"}).then(res=>{
          _this.banner = res.data.img;
        })
      },
      askQuestion(){
        var _this = this;
        if(this.ask_text===""){
          this.$message.error("请输入内容后提问")
        }else{
          var date = new Date();
          var data = {
            "question":this.ask_text,
            "type":"咨询",
            "addtime":date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate(),
          };
          addQuestion(data).then(res=>{
            if(res.status==="200"){
              _this.$message.success("提问成功");
              _this.getUserList();
              _this.ask_text = "";
            }
          })
        }
      },
      /**
       * 获取分类列表
       */
      getUserList() {
        var _this = this;
        getUserAsk().then(res=>{
          _this.ask_data=res.data;
        })
      },
      _token() {
        this.token = sessionStorage.getItem('token')
      },
      /**
       * 获取留言列表
       */
      getLangLists() {
        var _this = this;
        getQuestions().then(res=>{
          _this.langList = res.data;
        })
      },
      searchKeyword() {
        this.getLangLists()
      },
      handlePage(){
      }
    }
  }
</script>
<style lang="less">
  .qu-con {
    width: 1200px;
    margin: 0 auto;
    padding-top: 50px;
    padding-bottom: 60px;

    .answers-box {
      width: 800px;
      float: left;
      -webkit-border-radius: 2px;
      -moz-border-radius: 2px;
      border-radius: 2px;
      .answers {
        padding: 30px;
        background: #fff;
        box-shadow: 0 3px 36px 0 #EDEDED;
        .search {
          position: relative;
          width: 300px;
          float: right;
          input {
            border: 1px solid #dddee1;
            font-size: 15px;
            border-radius: 2px;
            background: #fff;
            color: #666;
            width: 100%;
            padding: 8px 35px 8px 10px;
            &:focus {
              border-color: #57a3f3;
              outline: 0;
              box-shadow: 0 0 0 2px rgba(45, 140, 240, .2);
              -webkit-transition: all .3s ease-in-out;
              transition: all .3s ease-in-out;
            }
          }
          .ico {
            position: absolute;
            right: 10px;
            font-size: 26px;
            top: 2px;
            cursor: pointer;
          }
        }
      }
      .answers-list {
        clear: both;
        li {
          padding: 30px 0;
          border-bottom: 1px dashed #d4d4d4;
          .date {
            float: left;
            width: 60px;
            text-align: center;
            margin-right: 15px;
            color: #d72c27;
            .day {
              font-size: 38px;
              display: block;
            }
            .month {
              font-size: 14px;
              display: block;
            }
          }
          .answers-item {
            float: left;
            width: 645px;
            margin-top: 10px;
            .q {
              font-size: 24px;
              color: #333;
              margin-bottom: 15px;
              span {
                font-size: 16px;
                padding: 3px 10px;
                background-image: linear-gradient(90deg,
                #ff342e 0%,
                #ff7d7f 0%,
                #d72c27 0%,
                #ca2723 100%),
                linear-gradient(
                  #ffffff,
                  #ffffff);
                margin-left: 10px;
                color: #fff;
                border-radius: 2px;
              }
            }
            .a {
              font-size: 16px;
              text-indent: 20px;
              line-height: 24px;
            }
          }
          &:last-child {
            border-bottom: none;
          }
        }
      }
    }
    .ask-box{
      float: left;
      width: 350px;
      margin-left: 50px;
      .answers{
        width: 350px;
        .title{
          text-align: center;
          font-size: 20px;
          color: #818181;
        }
        .answers-myself{
          .answers-item{
            margin-top: 20px;
            font-size: 15px;
            .answer{
              margin-top: 5px;
            }
            .time{
              text-align: right;

            }
          }
        }
        textarea {
          margin-top: 20px;
          border: 1px solid #dddee1;
          outline: 0;
          width: 100%;
          color: #495060;
          border-radius: 4px;
          padding: 5px 8px;
          font-size: 14px;
          &:focus {
            border-color: #57a3f3;
            outline: 0;
            box-shadow: 0 0 0 2px rgba(45, 140, 240, .2);
            -webkit-transition: all .3s ease-in-out;
            transition: all .3s ease-in-out;
          }
        }
        input {
          margin-top: 20px;
          -webkit-transition: all .3s ease-in-out;
          transition: all .3s ease-in-out;
          background: #fff;
          box-shadow: none;
          color: #495060;
          font-size: 14px;
          width: 100%;
          padding: 5px 8px;
          border: 1px solid #dddee1;
          border-radius: 4px;
          height: 38px;
          &:active {
            line-height: 20px;
            border-color: #f3482b;
            box-shadow: 0 0 0 2px rgba(240, 76, 82, 0.2);
            -webkit-transition: all .3s ease-in-out;
            transition: all .3s ease-in-out;
          }
          &:hover{
            cursor: pointer;
            border-color: #57a3f3;
            outline: 0;
            box-shadow: 0 0 0 2px rgba(45, 140, 240, .2);
            -webkit-transition: all .3s ease-in-out;
            transition: all .3s ease-in-out;
          }
        }
      }
    }
    .ques {
      width: 370px;
      border-radius: 2px;
      background: #fff;
      float: right;
      padding: 32px 38px;
      box-shadow: 0 3px 36px 0 #EDEDED;
      .tit {
        font-size: 22px;
        color: #333;
        margin-bottom: 30px;
      }
      .form-box {
        margin-top: 30px;
        .form-group {
          position: relative;
          width: 100%;
          margin-top: 20px;

          .form_item {
            float: left;
            width: 60%;
            position: relative;

          }
          .code-img {
            float: right;
            height: 38px;
            border-radius: 4px;
            overflow: hidden;
            img {
              height: 100%;
            }
          }

          label.error.is-visible {
            visibility: visible;
            opacity: 1;
            right: 0;
            -ms-filter: "alpha(Opacity=100)";
            -webkit-transform: translate(0, 0);
            -ms-transform: translate(0, 0);
            transform: translate(0, 0);
            -webkit-transition: .3s ease-out;
            transition: .3s ease-out;
          }
          label.error {
            position: absolute;
            top: 11px;
            right: -60px;
            padding: 0 8px;
            opacity: 0;
            color: #c33;
            cursor: text;
            -webkit-transform: translate(20px, 0);
            -ms-transform: translate(20px, 0);
            transform: translate(20px, 0);
            -webkit-transition: .25s ease-out;
            transition: .25s ease-out;
          }
          .input-btn {
            cursor: pointer;
            width: 100%;
            height: 38px;
            text-align: center;
            line-height: 38px;
            font-size: 14px;
            border-radius: 2px;
            margin-top: 20px;
            letter-spacing: 3px;
            background: rgb(52, 152, 233);
            color: #fff;
          }
        }
      }
    }
  }

</style>
