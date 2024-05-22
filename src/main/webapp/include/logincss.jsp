<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.body-layout {
		display: grid;
		grid-template-areas: 'header' 'content';
		grid-template-rows: 100px 1fr;
	}
	.menu-title {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.navbar-brand {
		margin: 0 auto;
	}
	.content-list {
		width: 30%;
		padding: 30px;
		margin: 50px auto 100px;
		box-sizing: content-box;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, .1), 0 0 1px rgba(0, 0, 0, .3);
	}
	.grayBtn, .orangeBtn {
		width: 80%;
	}
	label {
		font-family: 'Pretendard-SemiBold';
		color: gray;
	    display: block;
	    text-align: left;
	}
	.btn-gray {
		background-color: #eee;
		color: gray;
		border: none;
	}
	.btn-gray:hover {
		background-color: #ddd;
		color: gray;
	}

</style>