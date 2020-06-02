<template>
    <div>
        <el-row :gutter="20">
            <el-col :span="8">
                <el-card shadow="hover" class="mgb20" style="height:200px;">
                    <div class="user-info">
                        <img src="../../assets/img/img.jpg" class="user-avator" alt="">
                        <div class="user-info-cont">
                            <div class="user-info-name">{{name}}</div>
                            <div>{{role}}</div>
                            <div>上次登录位置：韶关</div>
                            <div>上次登录时间：2019-12-01 15:35:46</div>
                        </div>
                    </div>
                </el-card>
                <el-card class="mainSetting" shadow="hover" style="height:300px;">
                    <el-row>
                        <div style="font-size: 25px;margin-bottom: 15px;">设置</div>
                    </el-row>
                    <el-row>
                        <span>开始时间 ：</span>
                        <el-time-select
                                placeholder="开始时间"
                                v-model="config.a1"
                                style="width: 350px;"
                                :picker-options="{
                              start: '07:00',
                              step: '01:00',
                              end: '24:00',
                            }">
                        </el-time-select>
                    </el-row>
                    <el-row>
                        <span>结束时间 ：</span>
                        <el-time-select
                                placeholder="结束时间"
                                v-model="config.a2"
                                style="width: 350px;"
                                :picker-options="{
                              start: '12:00',
                              step: '01:00',
                              end: '24:00',
                              minTime: config.a1
                            }">
                        </el-time-select>
                    </el-row>
                    <el-row>
                        <span>首页公告 ：</span>
                        <el-input style="width: 350px;" v-model="config.a3" placeholder="首页公告"></el-input>
                    </el-row>
                    <el-row>
                        <el-button style="width: 440px;height: 40px;" @click="saveConfig" type="primary">保存</el-button>
                    </el-row>
                </el-card>
            </el-col>
            <el-col :span="16">
                <el-row :gutter="20" class="mgb20">
                    <el-col :span="8">
                        <el-card shadow="hover" :body-style="{padding: '0px'}">
                            <div class="grid-content grid-con-1">
                                <i class="el-icon-lx-people grid-con-icon"></i>
                                <div class="grid-cont-right">
                                    <div class="grid-num">{{config.a4}}</div>
                                    <div>用户访问量</div>
                                </div>
                            </div>
                        </el-card>
                    </el-col>
                    <el-col :span="8">
                        <el-card shadow="hover" :body-style="{padding: '0px'}">
                            <div class="grid-content grid-con-2">
                                <i class="el-icon-lx-notice grid-con-icon"></i>
                                <div class="grid-cont-right">
                                    <div class="grid-num">321</div>
                                    <div>总咨询数</div>
                                </div>
                            </div>
                        </el-card>
                    </el-col>
                    <el-col :span="8">
                        <el-card shadow="hover" :body-style="{padding: '0px'}">
                            <div class="grid-content grid-con-3">
                                <i class="el-icon-lx-goods grid-con-icon"></i>
                                <div class="grid-cont-right">
                                    <div class="grid-num">100</div>
                                    <div>日均访问量</div>
                                </div>
                            </div>
                        </el-card>
                    </el-col>
                </el-row>
                <el-row>
                    <el-card>
                        <div class="schart-box" >
                            <schart  class="schart" style="height: 390px;" canvasId="bar" :data="data1"  type="bar" :options="options1"></schart>
                        </div>
                    </el-card>
                </el-row>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    import Schart from 'vue-schart';
    import bus from '../common/bus';
    import {getConfig,setConfig} from '../../api';

    export default {
        name: 'dashboard',
        data() {
            return {
                name: localStorage.getItem('ms_username'),
                config:{},
                data1:[
                    {name:'2019-06',value:1141},
                    {name:'2019-07',value:1499},
                    {name:'2019-08',value:2260},
                    {name:'2019-09',value:1170},
                    {name:'2019-10',value:970},
                    {name:'2019-11',value:1450}
                ],
                options1: {
                    title: '近六个月网站访问量',
                    autoWidth: true,   // 设置宽高自适应
                    showValue: true,
                   // bgColor: '#F9EFCC',
                   // fillColor: '#00887C',
                    contentColor: 'rgba(46,199,201,0.3)',
                    yEqual: 7,

                },
            }
        },
        components: {
            Schart
        },
        computed: {
            role() {
                return this.name === 'admin' ? '超级管理员' : '普通用户';
            }
        },
        created(){
            this.getData();
        },
        activated(){
            this.handleListener();
        },
        deactivated(){
            window.removeEventListener('resize', this.renderChart);
            bus.$off('collapse', this.handleBus);
        },
        methods: {
            getData(){
                getConfig().then(res=>{
                    this.config = res.data;
                })
            },
            saveConfig(){
                setConfig(this.config).then(res=>{
                    if(res.status==='200'){
                        this.$message.success("保存成功");
                    }
                })
            }
        }
    }

</script>


<style scoped>
    .mainSetting{
        font-size: 17px;
        font-family: "Microsoft YaHei UI";
        padding: 15px;
    }
    .mainSetting input{
        width: 100px;
    }

    .el-row {
        margin-bottom: 20px;
    }

    .grid-content {
        display: flex;
        align-items: center;
        height: 100px;
    }

    .grid-cont-right {
        flex: 1;
        text-align: center;
        font-size: 14px;
        color: #999;
    }

    .grid-num {
        font-size: 30px;
        font-weight: bold;
    }

    .grid-con-icon {
        font-size: 50px;
        width: 100px;
        height: 100px;
        text-align: center;
        line-height: 100px;
        color: #fff;
    }

    .grid-con-1 .grid-con-icon {
        background: rgb(45, 140, 240);
    }

    .grid-con-1 .grid-num {
        color: rgb(45, 140, 240);
    }

    .grid-con-2 .grid-con-icon {
        background: rgb(100, 213, 114);
    }

    .grid-con-2 .grid-num {
        color: rgb(45, 140, 240);
    }

    .grid-con-3 .grid-con-icon {
        background: rgb(242, 94, 67);
    }

    .grid-con-3 .grid-num {
        color: rgb(242, 94, 67);
    }

    .user-info {
        display: flex;
        align-items: center;
        padding-bottom: 20px;
        border-bottom: 2px solid #ccc;
        margin-bottom: 20px;
    }

    .user-avator {
        width: 120px;
        height: 120px;
        border-radius: 50%;
    }

    .user-info-cont {
        padding-left: 50px;
        flex: 1;
        font-size: 14px;
        color: #999;
    }

    .user-info-cont div:first-child {
        font-size: 30px;
        color: #222;
    }

    .user-info-list {
        font-size: 14px;
        color: #999;
        line-height: 25px;
    }

    .user-info-list span {
        margin-left: 70px;
    }

    .mgb20 {
        margin-bottom: 20px;
    }

    .todo-item {
        font-size: 14px;
    }

    .todo-item-del {
        text-decoration: line-through;
        color: #999;
    }

    .schart {
        width: 100%;
        height: 300px;
    }

</style>
