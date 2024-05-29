<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>글작성</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/blogInputcss.jsp"%>
<style>
	@font-face {
	 font-family: '나눔바른고딕';
	 font-style: normal;
	 font-weight: 400;
	 src: url('//fastly.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
	 src: url('//fastly.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix') format('embedded-opentype'), url('//fastly.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff') format('woff'), url('//fastly.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf') format('truetype');
	}
	@font-face {
	    font-family: '리디바탕';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	@font-face {
	    font-family: '서울남산체';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SeoulNamsanM.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	@font-face {
	    font-family: '둘기마요고딕';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}
	@font-face {
	    font-family: '매일옥자체';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2403@1.0/Ownglyph_Dailyokja-Rg.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}
	@font-face {
	    font-family: '밑미폰트';
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_1@1.0/Ownglyph_meetme-Rg.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}
	#editor-container {
		width: 100%;
		margin: 0 auto;
	}
    .note-editable {
      margin: 10px;
      line-height: 0.5;
      font-family: '나눔바른고딕', '리디바탕', '서울남산체', '둘기마요고딕', '매일옥자체', '밑미폰트', sans-serif;
      background-color: #fff;
    }
    input[type="text"] {
    	font-size: 24px;
    }
</style>
<script>
	'use strict';
	// 작성 버튼
	function writeBtn() {
	    let writeHeaderLayer = document.querySelector('.menu-right-bar .layer_write');
	
	    // 작성 버튼의 header_layer가 없는 경우 생성
	    if (!writeHeaderLayer) {
	        let headerLayer = document.createElement('div');
	        headerLayer.className = 'header_layer layer_write';
	        headerLayer.innerHTML = '<div class="layer_write_header">'
	        	+'<form id="contentInputForm" method="post">'
		        +'<table class="table table-borderless text-center">'
		        +'<tr><td class="table-label">카테고리</td>'
		        +'<td class="table-content">'
		        +'<select name="category" id="category" class="custom-select">'
		        +'<c:forEach var="cPVo" items="${cPVos}">'
		        +'<option value="${cPVo.caIdx}">${cPVo.category}</option>'
		        +'<c:forEach var="cCVo" items="${cCVos}">'
		        +'<c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">'
		        +'<option value="${cCVo.caIdx}">&nbsp;-&nbsp;${cCVo.category}</option>'
		        +'</c:if></c:forEach></c:forEach>'
		        +'</td></tr>'
		        +'<tr><td class="table-label">주제</td>'
		        +'<td class="table-content">'
		        +'<select name="part" id="part" class="custom-select">'
		        +'<option value="없음" selected>주제 선택 안 함</option>'
		        +'<option>일상</option>'
		        +'<option>취미</option>'
		        +'<option>공연/전시</option>'
		        +'<option>게임</option>'
		        +'<option>패션/미용</option>'
		        +'<option>비즈니스/경제</option>'
		        +'<option>육아/결혼</option>'
		        +'<option>문학/책</option>'
		        +'</td></tr>'
		        +'<tr><td class="table-label">공개 설정</td>'
		        +'<td class="table-content">'
		        +'<input type="radio" name="publicSetting" id="publicSetting1" value="공개" checked>&nbsp;공개&nbsp; &nbsp;&nbsp; &nbsp;'
		        +'<input type="radio" name="publicSetting" id="publicSetting2" value="비공개"/>&nbsp;비공개'
		        +'</td></tr>'
		        +'<tr><td colspan="2" style="margin:0 auto;">'
		        +'<input type="button" class="mt-2 proBtn" value="작성" onclick="writeContent()">'
		        +'</td></tr>'
				+'</table>'
				+'<input type="hidden" name="mid" id="mid" value="${sMid}" />'
				+'<input type="hidden" name="hostIp" id="hostIp" value="${pageContext.request.remoteAddr}" />'
				+'</form>'
	        	+'</div>';
	        document.querySelector('.menu-right-bar').appendChild(headerLayer);
	        document.addEventListener('click', handleClickOutsideWrite);
	    } else { // 작성 버튼의 header_layer가 있는 경우 제거
	    	writeHeaderLayer.remove();
	        document.removeEventListener('click', handleClickOutsideWrite);
	    }
	}
	
	function handleClickOutsideWrite(e) {
	    let writeHeaderLayer = document.querySelector('.menu-right-bar .layer_write');
	    if (writeHeaderLayer && !writeHeaderLayer.contains(e.target) && !e.target.matches('.menu-right-bar *')) {
	    	writeHeaderLayer.remove();
	        document.removeEventListener('click', handleClickOutsideWrite);
	    }
	}
</script>
</head>
<body class="body-layout">
	<div class="menu-title">
		<a class="navbar-brand" href="${ctp}/Main"><img src="${ctp}/images/logo.png" alt="logo" style="width: 200px;"></a>
		<div class="menu-right-bar">
			<button class="orangeBtn-sm" onclick="writeBtn()">작성</button>
		</div>
	</div>
	<main>
		<div class="container">
			<div id="editor-container">
				<form id="postForm" method="post">
					<input type="text" name="title" id="title" placeholder="제목을 입력하세요" class="form-control mb-3" />
			  		<textarea id="summernote" name="content"></textarea>
				</form>
			</div>
		</div>
	</main>

<!-- Summernote JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

  <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title" id="modalTitle"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div id="modalText"></div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary btn-gray" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>

<script>
	let initialImages = [];
	let currentImages = [];
	
    $(document).ready(function() {
    	var fontList = ['나눔바른고딕', '리디바탕', '서울남산체', '둘기마요고딕', '매일옥자체', '밑미폰트'];
      $('#summernote').summernote({
    	lang: 'ko-KR',
        tabsize: 2,
        height: 700,
        toolbar: [
		    // [groupName, [list of button]]
		    ['fontname', ['fontname']],
		    ['fontsize', ['fontsize']],
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    ['color', ['forecolor','color']],
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['insert',['picture','link','video']],
		    ['view', ['help']]
      	],
		fontNames: fontList,
		fontNamesIgnoreCheck: fontList,
		fontSizes: ['10','11','12','14','16','18','20','22','24'],
        callbacks: {
            onInit: function() {
            	// 초기 내용 저장
            	initialContent = $('#summernote').summernote('code');
                // 기본 폰트 설정
                $('.note-editable').css('font-family', '나눔바른고딕');
              },
	          onImageUpload: function(files) {
	        	  if(files.length > 0){
	        		  let file = files[0];
	        		  let maxSize = 1024 * 1024 * 10;
	        		  
	        		  let fileTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
	        		  if(fileTypes.indexOf(file.type) === -1) {
	      				$("#myModal #modalTitle").text("파일 오류");
	    				$("#myModal #modalText").text("이미지 파일만 업로드해주세요!");
	    			    $('#myModal').modal('show');
						return;
	        		  }
	        		  
	        		  if(file.size > maxSize) {
	      				$("#myModal #modalTitle").text("파일 오류");
	    				$("#myModal #modalText").text("파일의 최대 크기는 10MB입니다!");
	    			    $('#myModal').modal('show');
				        return;
	        		  }
	        		  uploadImage(files[0]);
	        	}
	          },
              onChange: function(contents, $editable) {
                  currentImages = getCurrentImages(); // 현재 에디터의 모든 이미지 배열로 가져옴
                  detectDeletedImages(initialImages, currentImages); // 초기 이미지 배열과 현재 이미지 배열 비교해 삭제이미지 감지해 삭제
                  initialImages = currentImages; // 현재 이미지 배열을 초기 이미지 배열로 설정
                }
       		}
      });
    });

    	// 이미지 등록
		function uploadImage(file) {
			let data = new FormData();
			data.append("file", file);

			$.ajax({
			  url: '${ctp}/ContentImageUpload',
			  cache: false,
			  contentType: false,
			  processData: false,
			  data: data,
			  type: "POST",
			  success: function(url) {
		          $('#summernote').summernote('insertImage', url, function ($image) {
		              $image.attr('src', url);
		              initialImages.push(url); // 추가된 이미지를 초기 이미지 목록에 추가
		            });
			  },
			  error: function() {
   				$("#myModal #modalTitle").text("전송 오류");
   				$("#myModal #modalText").text("전송 오류!");
   			    $('#myModal').modal('show');
			  }
			});
		}
		
		// 현재 에디터에 포함된 이미지 URL을 배열로 반환
		function getCurrentImages() {
			  return $('#summernote').next('.note-editor').find('.note-editable img').map(function() {
			    return $(this).attr('src');
			  }).get();
			}
	    
	    function detectDeletedImages(initialImages, currentImages) {
	        initialImages.forEach(function(src) {
	          // 이미지가 삭제된 경우
	          if (!currentImages.includes(src)) {
	            deleteImage(src);
	          }
	        });
	      }
		
	    // 이미지 삭제
	    function deleteImage(src) {
	        $.ajax({
	          url: '${ctp}/ContentImageDelete', // 이미지를 삭제할 서버 URL을 여기에 넣습니다.
	          type: 'POST',
	          data: { src : src },
	          error: function() {
	            console.log('이미지 삭제 실패');
	          }
	        });
	      }
	    
	    // 글 작성
	    function writeContent() {
			let mid = $('#mid').val();
			let title = $('#title').val().trim();
			let content = $('#summernote').summernote('code').trim();
			let category = $('#category').val();
			let part = $('#part').val();
			let hostIp = $('#hostIp').val();
			let publicSetting = $('input[name="publicSetting"]:checked').val();
			
			if (title == '') {
   				$("#myModal #modalTitle").text("글 제목");
   				$("#myModal #modalText").text("글 제목을 입력하세요!");
   			    $('#myModal').modal('show');
   		        $('#myModal').on('hide.bs.modal', function () {
					$('#title').focus();
   		        });
				return false;
			}
			
			if (content == '' || content == '<p><br></p>') {
   				$("#myModal #modalTitle").text("글 내용");
   				$("#myModal #modalText").text("글 내용을 입력하세요!");
   			    $('#myModal').modal('show');
   		        $('#myModal').on('hide.bs.modal', function () {
					$('#summernote').focus();
   		        });
				return false;
			}
			
			
			let query = {
				mid : mid,
				title : title,
				content : content,
				category : category,
				part : part,
				hostIp : hostIp,
				publicSetting : publicSetting
			}
			  
			  $.ajax({
				  url : "${ctp}/ContentInputOk",
				  type : "post",
				  data : query,
				  success : function(res) {
					if(res != "0"){
						location.href="${ctp}/blog/${sMid}";
					}
					else {
		   				$("#myModal #modalTitle").text("작성 오류");
		   				$("#myModal #modalText").text("게시글 등록 실패!");
		   			    $('#myModal').modal('show');
					}
				},
				error : function() {
	   				$("#myModal #modalTitle").text("전송 오류");
	   				$("#myModal #modalText").text("전송 오류!");
	   			    $('#myModal').modal('show');
				}
			});
		}
  </script>
</body>
</html>