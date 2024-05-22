<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	@font-face {
	    font-family: 'Pretendard-Thin';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Thin.woff') format('woff');
	    font-weight: 100;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-ExtraLight';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-ExtraLight.woff') format('woff');
	    font-weight: 200;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Light';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Light.woff') format('woff');
	    font-weight: 300;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Medium';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Medium.woff') format('woff');
	    font-weight: 500;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-SemiBold';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-SemiBold.woff') format('woff');
	    font-weight: 600;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Bold';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Bold.woff') format('woff');
	    font-weight: 700;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-ExtraBold';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-ExtraBold.woff') format('woff');
	    font-weight: 800;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Black';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Black.woff') format('woff');
	    font-weight: 900;
	    font-style: normal;
	}
	.font-light {font-family: 'Pretendard-Light';}
	.font-semiBold {font-family: 'Pretendard-SemiBold';}
	.font-bold {font-family: 'Pretendard-Bold';}
	body {
		font-family: 'Pretendard-Medium';
	}
	.body-layout {
		display: grid;
		grid-template-areas: 'header' 'menu' 'content' 'footer';
		grid-template-rows: 110px 80px 1fr 100px;
	}
	.menu-title {
		grid-area: header;
		display: flex;
 		padding: 30px 30px 0px 30px;
 		justify-content: space-between;
	}
	.menu {
		font-size: 20pt;
		padding-left: 40px;
		grid-area: menu;
	}
	.menu2 {
		font-size: 14pt;
		padding-left: 20px;
		display: flex;
		justify-content: center;
	}
	nav {
	  position: relative;
	  display: flex;
	  height: 50px;
	  width: 330px;
	  color: #A6A6A6;
	}
	nav div {
	  width: 100px;
	  line-height: 60px;
	  cursor: pointer;
	  font-family: 'Pretendard-SemiBold';
	  font-size: 26pt;
	}
	nav .animation {
	  position: absolute;
	  top: 100%;
	  left: 5px;
	  width: 55px;
	  height: 2px;
	  background-color: #afeeee;
	  transition: 0.5s;
	}
	nav div:nth-child(1).active ~ .animation {
	  left: 5px;
	}
	nav div:nth-child(2).active ~ .animation {
	  left: 114px;
	}
	nav div:nth-child(3).active ~ .animation {
	  left: 222px;
	}
	a:link {
  	color : gray;
	}
	a:visited {
	  color : gray;
	}
	a:hover {
	  color : #ff7200;
	  text-decoration-line: none;
	}
	a:active {
	  color : #ff7200;
	}
	.content-box a:link {
  	color : #ff7200;
	}
	.content-box a:visited {
	  color : #ff7200;
	}
	.content-box a:hover {
	  color : #afeeee;
	  text-decoration-line: none;
	}
	.content-box a:active {
	  color : #afeeee;
	}
	.main-content {
		grid-area: content;
	}
	.footer {
		grid-area: footer;
		background-color: #eee;
    	display: flex;
    	justify-content: center;
    	align-items: center;
	}
	.content-list{
		text-align: center;
	}
	.orangeBtn{
		font-family: 'Pretendard-Light';
		display: inline-block;
		outline: none;
		cursor: pointer;
		font-size: 15px;
		line-height: 1;
		border-radius: 500px;
		transition-property: background-color,border-color,color,box-shadow,filter;
		transition-duration: .3s;
		border: 1px solid transparent;
		letter-spacing: 2px;
		min-width: 160px;
		text-transform: uppercase;
		white-space: normal;
		font-weight: 700;
		text-align: center;
		padding: 16px 14px 18px;
		color: #fff;
		background-color: #ff7200;
		height: 48px;
	}
	.orangeBtn-sm{
		font-family: 'Pretendard-Light';
		display: inline-block;
		outline: none;
		cursor: pointer;
		font-size: 13px;
		line-height: 1;
		border-radius: 500px;
		transition-property: background-color,border-color,color,box-shadow,filter;
		transition-duration: .3s;
		border: 1px solid transparent;
		letter-spacing: 2px;
		min-width: 120px;
		text-transform: uppercase;
		white-space: normal;
		font-weight: 600;
		text-align: center;
		padding: 14px 14px 18px;
		color: #fff;
		background-color: #ff7200;
		height: 42px;
		margin: 0 10px;
	}
	.grayBtn{
		font-family: 'Pretendard-Light';
		display: inline-block;
		outline: none;
		cursor: pointer;
		font-size: 15px;
		line-height: 1;
		border-radius: 500px;
		transition-property: background-color,border-color,color,box-shadow,filter;
		transition-duration: .3s;
		border: 1px solid transparent;
		letter-spacing: 2px;
		min-width: 160px;
		text-transform: uppercase;
		white-space: normal;
		font-weight: 700;
		text-align: center;
		padding: 16px 14px 18px;
		color: gray;
		background-color: #eee;
		height: 48px;
	}
	i{cursor: pointer;}
	.orangeBtn:hover, .orangeBtn-sm:hover{
	    background-color: #afeeee;
	    color: gray;
	}
	.grayBtn:hover{
	    background-color: #ddd;
	}
	.menu-right-bar {
		display: flex;
		align-items:flex-start;
		justify-content: center;
		gap: 40px;
	}
	body::-webkit-scrollbar {
	    width: 10px;  
	}
	
	body::-webkit-scrollbar-thumb {
	    background: #ff7200;
	    border-radius: 10px;
	    height: 30px;
	}
	
	body::-webkit-scrollbar-track {
	    background: #afeeee;
	}
	.login-title-text{
		font-size: 24pt;
		color: gray;
		margin: 100px 0;
	}
	.main-blog{
		color: gray;
	}
	.active-color {color: #ff7200!important;}
	.content-bt{
		padding: 0px 50px 50px 50px;
	}
	.content-box{
		width: 76%;
		padding: 30px;
		margin: 0 auto;
		display: flex;
		gap: 50px;
	}
	.content-box h3{
		font-family: 'Pretendard-Bold';
		color: #ff7200;
	}
	.content-box .blog-user-info{
		color: gray;
		font-size: 13pt;
	}
	.content-box .blog-date {
		color: #D5D5D5;
		font-family: 'Pretendard-Light';
	}
	.content-box > .text-box{
		display: flex;
		flex-direction: column;
	}
	.content-box-line {width:74%;}
	.content-text {
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 4;
		-webkit-box-orient: vertical;
		color: #747474;
		font-family: 'Pretendard-Light';
	}
	input {
	    font-family: 'Pretendard-Light';
	    color: #D5D5D5;
	}
	.imgBox {
		width: 200px;
		height: 200px;
		flex-shrink: 0;
	}
	.imgBox img{
	    width: 100%;
        height: 100%;
		object-fit: cover;
	}
	.user-profile {
		margin-right: 30px;
	}
	.user-profile img {
		width: 50px;
		height: 50px;
		object-fit: cover;
		border-radius: 50%;
		cursor: pointer;
	}
	.header_layer {
	    position: absolute;
	    top: 84px;
	    right: 30px;
	    width: 300px;
	    border-radius: 3px;
	    background-color: #fff;
	    box-sizing: content-box;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, .1), 0 0 1px rgba(0, 0, 0, .3);
	    text-align: left;
	}
	.header_layer:after {
	    content: "";
	    position: absolute;
	    top: -8px;
	    right: 24px;
	    width: 16px;
	    height: 9px;
	    background-image: url(https://t1.daumcdn.net/tistory_admin/static/top/pcrtn/layer_edge.png);
	    background-size: 16px 9px;
	}
	.layer_news {
	    top: 99px;
	    right: 128px;
	    width: 400px;
	}
	.layer_profile {
		top: 99px;
	    right: 53px;
	    width: 250px;
	    padding: 20px;
	    font-family: 'Pretendard-Light';
	}
	.sub-main{
		margin: 100px 0;
		font-size: 24pt;
	}
	.sub-blogs{
		width: 90%;
		display: flex;
		justify-content: center;
		gap: 50px;
		margin: 50px auto;
		flex-wrap: wrap;
	}
	.sub-blog{
		width: 17%;
		display: flex;
		flex-wrap: wrap;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		padding: 50px;
		box-sizing: content-box;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, .1), 0 0 1px rgba(0, 0, 0, .3);
	    color: gray;
	    gap: 10px;
	}
	.sub-blog img {
		width: 100px;
		height: 100px;
		border-radius: 50%;
		margin-bottom: 20px;
	}
	.blog-title {
		font-family: 'Pretendard-Bold';
		font-size: 16pt;
	}
	.blog-ment {
		height: 50px;
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 2;
		-webkit-box-orient: vertical;
		font-family: 'Pretendard-Light';
		color: #747474;
	}
	
	
	
	.layer_profile_header {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    margin-bottom: 6px;
	    color: #666;
	    
	}
	
	.layer_profile_username {
	    font-size: 18px;
	    font-family: 'Pretendard-Medium';
	}
	.u-mail_u-account {
		display: flex;
		justify-content: space-between;
		margin-bottom: 10px;
	}
	.layer_profile_email {
	    color: #A6A6A6;
	    font-size: 14px;
	}
	
	.layer_profile_account-management {
	    color: #A6A6A6;
	    cursor: pointer;
	    font-size: 14px;
	}
	.user_blogs {
	    margin-bottom: 20px;
	}
	
	.user_blog {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}
	.b-title {
		font-size: 12px;
		margin-bottom: 5px;
		color: #A6A6A6;
	}
	.user_blog-title {
	    font-size: 16px;
	    color: #747474;
	}
	
	.user_write-icon, .user_settings-icon {
	    margin-left: 10px;
	    color: #888;
	    cursor: pointer;
	}
	.user_logout {
		font-size: 12px;
	    color: #A6A6A6;
	    cursor: pointer;
	}
	
	
	
	.notification-top {
		padding: 10px;
	}
	.notification-hr {
	    margin: 0;
	}
	
	.notification-header {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    gap: 10px;
	}
	
	.notification-list {
	    width: 400px;
	    height: 400px;
	    overflow-y: auto;
	    overflow-x: hidden;
	}
	
	.notification {
	    display: flex;
	    align-items: flex-start;
	    padding: 10px;
	    border-bottom: 1px solid #eee;
	    cursor: pointer;
	    background-color: white;
	    transition: background-color 0.3s;
	}
	
	.notification:hover {
	    background-color: #f0f0f0;
	}
	
	.notification.clicked {
	    background-color: #ddd;
	}
	
	.profile-pic {
	    width: 50px;
	    height: 50px;
	    border-radius: 50%;
	    margin: 10px;
	}
	
	.notification-content {
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    padding: 10px;
	    font-size: 11pt;
	}
	.user {
	    margin: 0;
	}
	.user-name {
	    color: #ff7200;
	}
	.comment {
		margin-bottom: 10px;
	}
	.date {
	    font-size: 0.8em;
	    color: gray;
	    margin: 0;
	}
	.title {
		font-family: 'Pretendard-Light';
		margin: 0;
		color: #A6A6A6;
	}
</style>