<template>
    <div class="">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-lx-copy"></i>咨询问答</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <el-tabs v-model="message">
                <el-tab-pane :label="`未复消息(${unreply.length})`" name="first">
                    <el-table :data="unreply" :show-header="false" style="width: 100%">
                        <el-table-column>
                            <template slot-scope="scope">
                                <span class="message-title" @click="replyMessage(scope.$index,scope.row)">{{scope.row.user_name}}问 ： {{scope.row.question}}</span>
                            </template>
                        </el-table-column>
                        <el-table-column prop="addtime" width="180"></el-table-column>
                        <el-table-column prop="type" width="180"></el-table-column>
                        <el-table-column width="120">
                            <template slot-scope="scope">
                                <el-button type="danger" @click="deQuestion(scope.row.id)">不回复</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                    <div class="handle-row">
                        <el-button type="danger">全部不回复</el-button>
                    </div>
                </el-tab-pane>
                <el-tab-pane :label="`已复消息(${reply.length})`" name="second">
                    <template v-if="message === 'second'">
                        <el-table :data="reply" :show-header="false" style="width: 100%">
                            <el-table-column>
                                <template slot-scope="scope">
                                    <span class="message-title" @click="replyMessage(scope.$index,scope.row)">{{scope.row.user_name}}问 ： {{scope.row.question}}</span>
                                </template>
                            </el-table-column>
                            <el-table-column>
                                <template slot-scope="scope">
                                    <span class="answer-title">答 ： {{scope.row.answer}}</span>
                                </template>
                            </el-table-column>
                            <el-table-column prop="addtime" width="150"></el-table-column>
                            <el-table-column prop="type" width="180"></el-table-column>
                            <el-table-column width="120">
                                <template slot-scope="scope">
                                    <el-button type="danger" @click="deQuestion(scope.row.id)">删除</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                        <div class="handle-row">
                            <el-button type="danger">删除全部</el-button>
                        </div>
                    </template>
                </el-tab-pane>
            </el-tabs>
            <!-- 编辑弹出框 -->
            <el-dialog title="编辑" :visible.sync="editVisible" width="30%">
                <el-form ref="form" :model="form" label-width="70px">
                    <el-form-item :label="form.user_name">
                        <span>问：{{form.question}}</span>
                    </el-form-item>
                    <el-form-item label="回答">
                        <el-input type="textarea" v-model="form.answer"></el-input>
                    </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible=false">取 消</el-button>
                <el-button type="primary" @click="saveEdit">确 定</el-button>
            </span>
            </el-dialog>
        </div>
    </div>
</template>

<script>
    import {getQuestion,setQuestion,deleteQuestion} from '../../api';

    export default {
        name: 'tabs',
        data() {
            return {
                message: 'first',
                showHeader: false,
                unreply: [],
                reply: [],
                recycle: [],
                editVisible:false,
                form:[],
            }
        },
        methods: {
            replyMessage(index,row){
                this.editVisible=true;
                this.form=row;
            },
            saveEdit(){
                setQuestion(this.form).then(res=>{
                    if(res.status==='200'){
                        this.editVisible=false;
                        this.$message.success("回复成功");
                        this.getData();
                    }
                })
            },
            deQuestion(id){
                deleteQuestion({id:id}).then(res=>{
                    if(res.status==='200'){
                        this.$message.success('删除成功')
                        this.getData();
                    }else{
                        this.$message.error("删除失败");
                    }
                })
            },
            getData(){
                getQuestion().then(res=>{
                    this.unreply = res.data.data.unreply
                    this.reply = res.data.data.reply
                })
            },
            handleRead(index) {
                const item = this.unread.splice(index, 1);
                console.log(item);
                this.read = item.concat(this.read);
            },
            handleDel(index) {
                const item = this.read.splice(index, 1);
                this.recycle = item.concat(this.recycle);
            },
            handleRestore(index) {
                const item = this.recycle.splice(index, 1);
                this.read = item.concat(this.read);
            }
        },
        computed: {
            unreadNum(){
                return this.unread.length;
            }
        },
        created(){
            this.getData();
        }
    }

</script>

<style>
.message-title{
    cursor: pointer;
}
.handle-row{
    margin-top: 30px;
}
</style>

