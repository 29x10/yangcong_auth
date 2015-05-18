<!DOCTYPE html>
<html lang="${request.locale_name}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="pyramid web application">
    <meta name="author" content="Pylons Project">
    <link rel="shortcut icon" href="${request.static_path('yangcong_auth:static/pyramid-16x16.png')}">

    <title>洋葱登陆测试</title>

    <!-- Bootstrap core CSS -->
    <link href="//cdnjscn.b0.upaiyun.com/libs/twitter-bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>


<div class="container" style="width: 400px;margin-left: auto;margin-right: auto;margin-top: 20px;">
    <ul class="nav nav-pills">
        <li role="presentation" class="${'active' if request.params.get('auth_type', 'bind') == 'bind'  and request.path == '/' else ''}"><a href="/?auth_type=bind">绑定洋葱客户</a></li>
        <li role="presentation" class="${'active' if request.params.get('auth_type', 'bind') == 'auth' else ''}"><a href="/?auth_type=auth">通过洋葱进行验证</a></li>
        <li role="presentation" class="${'active' if 'page' in request.path else ''}"><a href="/auth_page/">洋葱登陆界面</a></li>
    </ul>
    ${self.body()}
</div>

<script src="//cdnjscn.b0.upaiyun.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="//cdnjscn.b0.upaiyun.com/libs/twitter-bootstrap/3.2.0/js/bootstrap.min.js"></script>

<%block name="extra_js">
</%block>
</body>
</html>
