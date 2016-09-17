<%@ page language="java" pageEncoding="UTF-8"%>
<script src="http://www.my97.net/dp/My97DatePicker/WdatePicker.js"></script>
<form id="admin_bookDetailEdit_editForm" method="post">
	<table>
		<input name="id" hidden="true" />
		<tr>
			<th>作者</th>
			<td><input name="author" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>出版社</th>
			<td><input name="publishing" style="width:80%" class="easyui-validatebox" data-options="required:true"></input>
			</td>
		</tr>
		<tr>
			<th>出版时间</th>
			<td><input name="publishTime" type="datetime" onclick="WdatePicker()" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>字数</th>
			<td><input name="wordNumber" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>修订版本</th>
			<td><input name="whichEdtion" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>		
		<tr>
			<th>总页数</th>
			<td><input name="totalPage" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>打印时间</th>
			<td><input name="printTime" style="width:80%" onclick="WdatePicker()" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
	    <tr>
			<th>打印次数</th>
			<td><input name="printNumber" style="width:80%"  class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>isbn号</th>
			<td><input name="isbn" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>作者简介</th>
			<td><input name="authorSummary" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>目录</th>
			<td><input name="catalogue" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
	</table>
	
</form>

