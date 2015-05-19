<%inherit file="base.mako" />
<div ng-app="auth" ng-controller="AuthController">

    <img src="${image_url}" style="width: 100%">

    <button class="btn btn-default" ng-click="check_scan()">检查扫描情况</button>

    <hr>

    <div class="sub-header">
        在线校验
    </div>

    <button class="btn btn-default" ng-click="online_auth()" ng-if="user_id">请求登陆</button>
    <button class="btn btn-default" ng-click="check_confirm()" ng-if="confirm_event_id">检查确认情况</button>

    <hr>
    <div class="sub-header">
        离线校验
    </div>
    <div class="form-group">
        <label for="code">6位码</label>
        <input type="text" class="form-control" id="code" ng-model="offline_code">
    </div>
    <button class="btn btn-default" ng-click="offline_auth()" ng-if="user_id">请求登陆</button>
</div>


<%block name="extra_js">
    <script src="//cdnjscn.b0.upaiyun.com/libs/angular.js/1.2.18/angular.min.js"></script>
    <script>
        angular.module('auth', []).controller('AuthController', ['$scope', '$http', function ($scope, $http) {
            $scope.scan_event_id = '${event_id}';
            $scope.user_id = '';
            $scope.confirm_event_id = '';
            $scope.offline_code = '';
            $scope.check_scan = function () {
                $http.get('/check?event_id=' + encodeURIComponent($scope.scan_event_id)).success(function (data) {
                    if (data.status == 200) {
                        $scope.user_id = data.uid;
                    } else {
                        alert(data.description);
                    }
                })
            };

            $scope.online_auth = function () {
                $http.get('/online_auth?uid=' + encodeURIComponent($scope.user_id)).success(function (data) {
                    if (data.status == 200) {
                        $scope.confirm_event_id = data.event_id;
                    } else {
                        alert(data.description);
                    }
                })
            };

            $scope.offline_auth = function () {
                $http.get('/offline_auth?uid=' + encodeURIComponent($scope.user_id) + '&code=' + encodeURIComponent($scope.offline_code)).success(function (data) {
                    if (data.status == 200) {
                        alert('登陆成功');
                    } else {
                        alert(data.description);
                    }
                })
            };


            $scope.check_confirm = function () {
                $http.get('/check?event_id=' + encodeURIComponent($scope.confirm_event_id)).success(function (data) {
                    if (data.status == 200) {
                        console.log(data);
                    } else {
                        alert(data.description);
                    }
                })
            };
        }]);
    </script>
</%block>
