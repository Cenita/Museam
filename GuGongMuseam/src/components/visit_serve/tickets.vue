<template>
  <div class="strategy">
    <banner
      :navs="navs"
      :banner="banner"
      :title="title"
      @handleClick="getBanner"/>
    <bg>
      <div class="strategy-con"  v-if="this.$store.state.islogin">
        <div>
          <p class="title">门票预约<span></span></p>
          <el-form ref="form" :model="form">
            <el-form-item>
              <el-select class="inpa" style="width: 100%;" v-model="tickdate" placeholder="请选择预约的日期">
                <el-option v-for="a in orderFor" :label="a.label" :value="a.value"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button v-if="isHashYuyue" type="primary" style="width: 100%;height:50px;" @click="res_tick">预约门票</el-button>
            </el-form-item>
          </el-form>
        </div>
        <div>
          <p class="title">我的预约<span></span></p>
          <el-table
            :data="reverData"
            style="width: 100%">
            <el-table-column
              prop="name"
              label="预约人"
              align="center"
            >
            </el-table-column>
            <el-table-column
              prop="date"
              label="预约日期"
              align="center"
              >
            </el-table-column>

            <el-table-column
              prop="addtime"
              label="预约的时间"
              align="center"
            >
            </el-table-column>
            <el-table-column
              align="center"
              label="操作"
            >
              <template slot-scope="scope">
                <el-button v-if="isCanCancel(scope)" type="text" size="small" @click="cancel(scope)">取消预约</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>
      <nologin v-else></nologin>
    </bg>
  </div>
</template>
<script type="text/ecmascript-6">
  Date.prototype.format = function(format)
  {
    var o = {
      "M+" : this.getMonth()+1, //month
      "d+" : this.getDate(),    //day
      "h+" : this.getHours(),   //hour
      "m+" : this.getMinutes(), //minute
      "s+" : this.getSeconds(), //second
      "q+" : Math.floor((this.getMonth()+3)/3),  //quarter
      "S" : this.getMilliseconds() //millisecond
    }
    if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
      (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)if(new RegExp("("+ k +")").test(format))
      format = format.replace(RegExp.$1,
        RegExp.$1.length==1 ? o[k] :
          ("00"+ o[k]).substr((""+ o[k]).length));
    return format;
  }
  import Banner from '@/base/banner'
  import Bg from '@/base/bg'
  import NoData from '@/base/no-data'
  import {getBanners,addTicket,getTicket,deleteTicket} from "../../public/js/api";
  import NoDoing from '@/base/no-doing';
  import nologin from '@/base/no-login';
  export default {

    components: {
      Banner,
      Bg,
      NoData,
      NoDoing,
      nologin
    },
    data() {
      return {
        navBar: [
          {title: '门票预约', id: 1},
        ],
        reverData:[
        ],
        navs: [
          {
            href: '/visit_serve/strategy',
            title: '参观攻略',
            id: 1
          },
          {
            href: '/visit_serve/tickets',
            title: '门票预约',
            id: 2
          }
        ],
        title: '门票预约',
        typeId: 1,
        roadTypes: [],
        showImg: '',
        banner:"",
        tickdate:"",
        orderList:[],
        orderFor:[],
        form:{}
      }
    },
    computed:{
      isHashYuyue(){
        var a = true;
        var _this = this;
        this.reverData.forEach(r=>{
          if(r.date==_this.tickdate){
            a = false;
          }
        })
        return a;
      },
      user_name() {
        return this.$store.state.name;
      },
    },
    created() {
      this.createOrderList(7);
      this.getBanner();
      this.getTypeList();
      this.getShowImg('s');
      this.updateData();
    },
    methods: {
      isCanCancel(scope){
        var d = new Date(scope.row.date);
        var now = new Date();
        if(d>=now){
          return true;
        }
        return false;
      },
      getDay(num, str) {
        var today = new Date();
        var nowTime = today.getTime();
        var ms = 24*3600*1000*num;
        today.setTime(parseInt(nowTime + ms));
        var oYear = today.getFullYear();
        var oMoth = (today.getMonth() + 1).toString();
        if (oMoth.length <= 1) oMoth = '0' + oMoth;
        var oDay = today.getDate().toString();
        if (oDay.length <= 1) oDay = '0' + oDay;
        return oYear + str + oMoth + str + oDay;
      },
      createOrderList(canReadDay){
        for(var i=0;i<=canReadDay;i++){
          this.orderList.push(this.getDay(i,"-"));
        }
      },
      updateData(){
        getTicket().then(res=>{
          if(res.status==="200"){
            this.reverData = res.data;
            this.updateOption();
          }
        })
      },
      /**
       * 获取参观攻略banner
       * @param id  分类id
       */
      cancel(a){
        deleteTicket({id:a.row.id}).then(res=>{
          if(res.status==='200'){
            this.reverData.splice(a.$index,1);
            this.$message.success("取消预约成功");
            this.updateOption();
          }
        })

      },
      isPrever(a){
        var s = true;
        this.reverData.forEach(r=>{
          if(r.date===a){
            s=false;
          }
        })
        if(s){
          return '可预约';
        }else{
          return '已预约';
        }
      },
      res_tick(){
        if(this.tickdate==""){
          this.$message.error("未选择预约的日期");
          return;
        }
        addTicket({date:this.tickdate}).then(res=>{
          if(res.status==="200"){
            this.$message.success("预约成功");
            this.updateData();
            this.updateOption();
          }
        })

      },
      getBanner() {
        var _this = this;
        getBanners({name:"门票预约"}).then(res=>{
          _this.banner = res.data.img;
        })
      },
      updateOption(){
        this.orderFor = [];
        this.orderList.forEach(r=>{
          this.orderFor.push({value:r,label:r+" "+this.isPrever(r)})
        })
      },
      handleTypeClick(typeId) {
        this.typeId = typeId
      },

      /**
       * 获取参观路线分类
       */
      getTypeList() {

      },

      toggleClick(id) {
        this.getShowImg(id)
      },

      /**
       * 获取参观路线对应id内容
       * @param id
       */
      getShowImg(id) {

      },

      //获取购票链接
      getTicketHref() {

      }
    }
  }
</script>
<style lang="less">
  .inpa{
    input{
      height: 50px!important;
    }
  }
  .strategy-con {
    &>*{
      margin-bottom: 50px;
    }
    width: 1200px;
    margin: 0 auto;
    padding-top: 50px;
    padding-bottom: 60px;
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
