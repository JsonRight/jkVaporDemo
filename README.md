<p align="center">
    <img src="https://cloud.githubusercontent.com/assets/1342803/24797159/52fb0d88-1b90-11e7-85a5-359fff0496a4.png" width="320" alt="MySQL">
    <br>
    <br>
    <a href="http://beta.docs.vapor.codes/getting-started/hello-world/">
        <img src="http://img.shields.io/badge/read_the-docs-92A8D1.svg" alt="Documentation">
    </a>
    <a href="http://vapor.team">
        <img src="http://vapor.team/badge.svg" alt="Slack Team">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/mysql">
        <img src="https://circleci.com/gh/vapor/mysql.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://travis-ci.org/vapor/api-template">
    	<img src="https://travis-ci.org/vapor/api-template.svg?branch=master" alt="Build Status">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-3.1-brightgreen.svg" alt="Swift 3.1">
    </a>
</center>
首次建立heroku
heroku login
git init
git add .
git commit -am "xxx"
vapor heroku init
/****/
1.Would you like to provide a custom Heroku app name?
你需要自定义你的Heroku app名字吗，当然需要,输入Y
2.Custom app name？
'你的APP名字，例testqq'
3.Would you like to provide a custom Heroku buildpack?
是否需要编译空间 输入N，
4.Are you using a custom Executable name?
N
5.Would you like to push to Heroku now?
Y
稍等会，推送完成之后就可以访问你的远程heroku服务器了

git commit -am "加了新东西"
git push heroku master


添加数据库
heroku addons:create heroku-postgresql:hobby-dev

查询数据库链接
heroku config -s | grep HEROKU_POSTGRESQL


vapor xcode -y
本想多添加点功能，比如图片上传啥的，结果发现七牛不行，就止步了，只能向大佬低头。有兴趣的同学双击666
