<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>
                    <i class="el-icon-lx-cascades"></i> 展览管理
                </el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button
                        type="primary"
                        icon="el-icon-delete"
                        class="handle-del mr10"
                        @click="addVisible=true;imageUrl=''"
                >增加展览</el-button>
                <el-button
                        type="danger"
                        icon="el-icon-delete"
                        class="handle-del mr10"
                        @click="delAllSelection"
                >批量删除</el-button>
                <el-select v-model="query.address" @change="getData" placeholder="展览类型" class="handle-select mr10">
                    <el-option key="1" label="全部展览" value="-1"></el-option>
                    <el-option key="2" label="即将展览" value="2"></el-option>
                    <el-option key="3" label="正在展览" value="1"></el-option>
                    <el-option key="4" label="展览回顾" value="3"></el-option>
                </el-select>
                <el-input v-model="query.name" placeholder="展览标题" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
            </div>
            <el-table
                :data="tableData"
                border
                class="table"
                ref="multipleTable"
                header-cell-class-name="table-header"
                @selection-change="handleSelectionChange"
            >
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column prop="id" label="ID" width="55" align="center"></el-table-column>
                <el-table-column width="250" prop="title" label="展览标题"></el-table-column>
                <el-table-column width="350" prop="introduce" label="展览简介"></el-table-column>

                <el-table-column width="250" label="展览宣传图" align="center">
                    <template slot-scope="scope">
                        <el-image
                            class="table-td-thumb"
                            :src="scope.row.img"
                        ></el-image>
                    </template>
                </el-table-column>
                <el-table-column prop="address" label="地址"></el-table-column>
                <el-table-column prop="reservation_number" label="预约人数" align="center"></el-table-column>
                <el-table-column prop="start_time" label="开始时间"></el-table-column>
                <el-table-column prop="end_time" label="结束时间"></el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button
                                type="text"
                                icon="el-icon-edit"
                                @click="checkRever(scope.row.id)"
                        >查看预约</el-button>
                        <el-button
                            type="text"
                            icon="el-icon-edit"
                            @click="handleEdit(scope.$index, scope.row)"
                        >编辑</el-button>
                        <el-button
                            type="text"
                            icon="el-icon-delete"
                            class="red"
                            @click="handleDelete(scope.$index, scope.row)"
                        >删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div class="pagination">
                <el-pagination
                    background
                    layout="total, prev, pager, next"
                    :current-page="query.pageIndex"
                    :page-size="query.pageSize"
                    :total="pageTotal"
                    @current-change="handlePageChange"
                ></el-pagination>
            </div>
        </div>
        <!-- 编辑弹出框 -->
        <el-dialog title="预约名单" :visible.sync="visiblePeople" width="50%">
            <el-table
                    :data="ReverData"
                    style="width: 100%">
                <el-table-column
                        prop="list.name"
                        label="名字">
                </el-table-column>
                <el-table-column
                        prop="list.phone"
                        label="手机号">
                </el-table-column>
                <el-table-column
                        prop="list.card"
                        label="身份证">
                </el-table-column>
                <el-table-column
                        prop="list.addTime"
                        label="预约成功的时间">
                </el-table-column>
            </el-table>
        </el-dialog>
        <!-- 编辑弹出框 -->
        <el-dialog title="编辑展览" :visible.sync="editVisible" width="50%">
            <el-form ref="form" :model="form" label-width="70px">
                <el-form-item label="展览标题">
                    <el-input v-model="form.title"></el-input>
                </el-form-item>
                <el-form-item label="展览简介">
                    <el-input type="textarea" v-model="form.introduce"></el-input>
                </el-form-item>
                <el-form-item label="详情介绍">
                    <el-input type="textarea" v-model="form.content"></el-input>
                </el-form-item>
                <el-form-item label="上传图片">
                    <el-upload
                            action="http://localhost:4269/api/Image"
                            :show-file-list="false"
                            :on-success="fileList">
                        <img v-if="imageUrl" :src="imageUrl" style="width: 100%;height: 100%" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="开始时间">
                    <el-date-picker
                            style="width: 100%"
                            v-model="form.start_time"
                            type="date"
                            placeholder="开始时间">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="结束时间">
                    <el-date-picker
                            style="width: 100%"
                            v-model="form.end_time"
                            type="date"
                            placeholder="结束时间">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="地址">
                    <el-input v-model="form.address"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible=false">取 消</el-button>
                <el-button type="primary" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>
        <!-- 增加弹出框 -->
        <el-dialog title="增加展览" :visible.sync="addVisible" width="50%">
            <el-form ref="form" :model="addform" label-width="70px">
                <el-form-item label="展览标题">
                    <el-input v-model="addform.title"></el-input>
                </el-form-item>
                <el-form-item label="展览简介">
                    <el-input type="textarea" v-model="addform.introduce"></el-input>
                </el-form-item>
                <el-form-item label="详情介绍">
                    <el-input type="textarea" v-model="addform.content" class="contentArea"></el-input>
                </el-form-item>
                <el-form-item label="上传图片">
                    <el-upload
                            action="http://localhost:4269/api/Image"
                            :show-file-list="false"
                            :on-success="fileList">
                        <img v-if="imageUrl" :src="imageUrl" style="width: 100%;height: 100%" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
                <el-form-item label="开始时间">
                    <el-date-picker
                            style="width: 100%"
                            v-model="addform.start_time"
                            type="date"
                            placeholder="开始时间">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="结束时间">
                    <el-date-picker
                            style="width: 100%"
                            v-model="addform.end_time"
                            type="date"
                            placeholder="结束时间">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="地址">
                    <el-input v-model="addform.address"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="addVisible=false">取 消</el-button>
                <el-button type="primary" @click="addExhibits">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import { getExhibit,setExhibit,addExhibit,deleteExhibit,getExhibitPeople } from '../../api/index';
export default {
    name: 'Exhibit',
    data() {
        return {
            query: {
                address: '-1',
                name: '',
                pageIndex: 1,
                pageSize: 10
            },
            ReverData:[],
            tableData: [],
            multipleSelection: [],
            delList: [],
            addVisible:false,
            editVisible: false,
            pageTotal: 0,
            form: {},
            addform:{},
            ExhibitType:"-1",
            idx: -1,
            id: -1,
            visiblePeople:false,
            imageUrl:""
        };
    },
    created() {
        this.getData();
    },
    methods: {
        fileList(response, file, fileList){
            var url = this.$url+"/"+response.list[0];
            this.imageUrl = url;
        },
        checkRever(id){
            var _this  = this;
            this.visiblePeople=true;
            getExhibitPeople({id:id}).then(res=>{
                if(res.status==='200'){
                    _this.ReverData = res.data.data;
                }
            })
        },
        // 获取 easy-mock 的模拟数据
        getData() {
            getExhibit(this.query).then(res => {
                this.tableData = res.data.data;
                this.pageTotal = 1;
            });
        },
        addExhibits(){
            this.addform.img = this.imageUrl;
            if(this.addform.img==""||this.addform.address==null||this.addform.content==null
                ||this.addform.end_time==null||this.addform.introduce==null||this.addform.start_time==null
                ||this.addform.title==null){
                this.$message.error("请填写完整");
                return;
            }
          addExhibit(this.addform).then(res=>{
              if(res.status==='200'){
                  this.addVisible=false;
                  this.$message.success("添加成功")
                  this.getData();
                  this.addform={};
              }else{
                  this.$message.error("添加失败");
              }
          })
        },
        // 触发搜索按钮
        handleSearch() {
            this.getData();
        },
        // 删除操作
        handleDelete(index, row) {
            // 二次确认删除
            this.$confirm('确定要删除吗？', '提示', {
                type: 'warning'
            })
                .then(() => {
                    deleteExhibit({id:row.id}).then(res=>{
                        if(res.status === '200'){
                            this.$message.success('删除成功');
                            this.getData();
                        }else{
                            this.$message.error('删除失败');
                        }
                    })
                })
                .catch(() => {});
        },
        // 多选操作
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        delAllSelection() {
            const length = this.multipleSelection.length;
            this.delList = this.delList.concat(this.multipleSelection);
            for (let i = 0; i < length; i++) {
                deleteExhibit({ id: this.multipleSelection[i].id }).then(res => {
                    if (res.status === '200') {
                        this.$message.success('删除成功');
                        this.getData();
                    } else {
                        this.$message.error('删除失败');
                    }
                })
            }
        },
        // 编辑操作
        handleEdit(index, row) {
            this.idx = index;
            this.form = row;
            this.editVisible = true;
            this.imageUrl = row.img;
        },
        // 保存编辑
        saveEdit() {
            this.form.img = this.imageUrl;
            setExhibit(this.form).then(res=>{
                if(res.status === '200'){
                    this.editVisible = false;
                    this.$message.success(`修改第 ${this.idx + 1} 行成功`);
                    this.$set(this.tableData, this.idx, this.form);
                }else{
                    this.$message.error('修改发生错误:'+res.data);
                }
            })
        },
        // 分页导航
        handlePageChange(val) {
            this.$set(this.query, 'pageIndex', val);
            this.getData();
        }
    }
};
</script>

<style scoped>
.contentArea{
}
.handle-box {
    margin-bottom: 20px;
}

.handle-select {
    width: 120px;
}

.handle-input {
    width: 300px;
    display: inline-block;
}
.table {
    width: 100%;
    font-size: 14px;
}
.red {
    color: #ff0000;
}
.mr10 {
    margin-right: 10px;
}
.table-td-thumb {
    display: block;
    margin: auto;
    width: 250px;
}
</style>
