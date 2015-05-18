# coding: utf-8
import hashlib
import json
from urllib import urlencode
import time
from urllib2 import urlopen
from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config


APP_ID = '6FmOm4XhfHu30QYfxcJXwzR3hioV1NUf'
APP_KEY = '37Yq55tt4gQCcTVtjEIy'
AUTH_ID = 'Pqsv6eOsIC4KtjYRDGO8'


@view_config(route_name='auth_page', renderer='auth_page.mako')
def my_view(request):
    if request.method == 'POST':
        signature = hashlib.md5()
        call_back_url = "http://localhost:6543/"
        timestamp = str(int(time.time()))
        signature.update('auth_id=' + AUTH_ID + 'callback=' + call_back_url + 'timestamp=' + timestamp + APP_KEY)
        auth_url = 'https://auth.yangcong.com/v2/auth_page?'
        return HTTPFound(location=auth_url + urlencode({
            'auth_id': AUTH_ID,
            'timestamp': timestamp,
            'callback': call_back_url,
            'signature': signature.hexdigest()
        }))
    return {'project': 'yangcong_auth'}



@view_config(route_name='offline_auth', renderer='json')
def offline_auth(request):
    signature = hashlib.md5()
    code = request.params.get('code', '')
    uid = request.params.get('uid', '')
    request_url = 'https://api.yangcong.com/v2/offline_authorization'
    signature.update('app_id=' + APP_ID + 'dynamic_code=' + code + 'uid=' + uid + APP_KEY)
    r = urlopen(request_url, data=urlencode({
        'app_id': APP_ID,
        'uid': uid,
        'dynamic_code': code,
        'signature': signature.hexdigest()
    }))
    return json.loads(r.read())


@view_config(route_name='bind', renderer='bind.mako')
def bind_view(request):
    if request.params.get('auth_type', 'bind') == 'bind':
        request_url = 'https://api.yangcong.com/v2/qrcode_for_binding?'
    else:
        request_url = 'https://api.yangcong.com/v2/qrcode_for_auth?'
    signature = hashlib.md5()
    signature.update('app_id=' + APP_ID + APP_KEY)
    r = urlopen(request_url + urlencode({
        'app_id': APP_ID,
        'signature': signature.hexdigest()
    }))
    bind_result = json.loads(r.read())
    return {
        'image_url': bind_result['qrcode_url'],
        'event_id': bind_result['event_id']
    }

@view_config(route_name='check', renderer='json')
def check_view(request):
    check_url = 'https://api.yangcong.com/v2/event_result?'
    signature = hashlib.md5()
    event_id = request.params.get('event_id', '')
    signature.update('app_id=' + APP_ID + 'event_id=' + event_id + APP_KEY)
    r = urlopen(check_url + urlencode({
        'app_id': APP_ID,
        'event_id': event_id,
        'signature': signature.hexdigest()
    }))
    return json.loads(r.read())


@view_config(route_name='online_auth', renderer='json')
def online_auth(request):
    signature = hashlib.md5()
    uid = request.params.get('uid', '1')
    request_url = 'https://api.yangcong.com/v2/realtime_authorization'
    signature.update('action_type=1app_id=' + APP_ID + 'uid=' + uid + APP_KEY)
    r = urlopen(request_url, data=urlencode({
        'action_type': '1',
        'app_id': APP_ID,
        'uid': uid,
        'user_ip': '10.0.0.2',
        'username': '绿茶浏览器',
        'signature': signature.hexdigest()
    }))
    return json.loads(r.read())