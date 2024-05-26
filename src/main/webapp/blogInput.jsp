<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Summernote Example</title>
  <!-- Summernote CSS -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
</head>
<body>
  <!-- Textarea for Summernote -->
  <form id="postForm" method="post" action="/save_post">
    <textarea id="summernote" name="content"></textarea>
    <button type="submit">Save</button>
  </form>

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- Summernote JS -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
  
  <script>
    $(document).ready(function() {
      $('#summernote').summernote({
        placeholder: 'Hello, Summernote!',
        tabsize: 2,
        height: 300,
        toolbar: [
          ['style', ['style']],
          ['font', ['bold', 'italic', 'underline', 'clear']],
          ['fontname', ['fontname']],
          ['color', ['color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['height', ['height']],
          ['insert', ['link', 'picture', 'video']],
          ['view', ['fullscreen', 'codeview', 'help']]
        ],
        callbacks: {
          onImageUpload: function(files) {
            uploadImage(files[0]);
          }
        }
      });
    });

    function uploadImage(file) {
      let data = new FormData();
      data.append("file", file);
      $.ajax({
        url: '/images/content', // 이미지를 업로드할 서버 URL을 여기에 넣습니다.
        cache: false,
        contentType: false,
        processData: false,
        data: data,
        type: "POST",
        success: function(url) {
          $('#summernote').summernote('insertImage', url, function ($image) {
            $image.attr('src', url);
          });
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log(textStatus + " " + errorThrown);
        }
      });
    }
  </script>
</body>
</html>