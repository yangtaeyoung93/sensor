<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8' %>
<%@ taglib prefix='sec' uri='http://www.springframework.org/security/tags' %>
<!DOCTYPE html>
<html>

<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Document</title>
    <script type='text/javascript' src='../../share/js/jquery-1.12.4.min.js'></script>
    <script src='../../share/alertifyjs/alertify.min.js'></script>
    <link rel='stylesheet' type='text/css' href='../../share/alertifyjs/css/alertify.min.css' />
    <link rel='stylesheet' type='text/css' href='../../share/alertifyjs/css/bootstrap.min.css' />
</head>

<body>
    <script>
        window.onload = function () {
            alertify.alert('에러', '권한이 없습니다.', function () {
                history.back();
            })
        }
    </script>
    <div></div>
</body>

</html>