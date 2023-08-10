# Swith, 함께 공부하기

## [🚀Swith 방문하기]()

<br>

# 📖 목차

- [개요](#📃개요)
- [개발 환경](#개발-환경)
- [사용 기술](#사용-기술)
- [프로젝트 목적](#프로젝트-목적)
- [화면 구성](#화면-구성💻)
- [핵심 기능](#핵심-기능⭐)
  - [방(Room)](#🌠방room)
  - [채팅(Chat)](#🌠채팅chat)
  - [회원(Users)](#🌠회원users)
- [느낀점](#느낀점)

## 📃개요

<img src="https://github.com/YoungJunKim-Dev/swith/assets/114643395/7e52cbb8-2660-414e-bf55-f5abefc13527" width="200" height="200"/>

**Swith**은 같은 공부 관심사를 가진 사람들이 모여 함께 공부할 수 있도록 개발한 모바일 애플리케이션입니다.<br>
현재는 1대1 개인간의 채팅 기능만 구현하였습니다.<br>

## 개발 환경

![windows11](https://img.shields.io/badge/Windows11-black?style=flat&logo=windows11)&nbsp;![VisualStudioCode](https://img.shields.io/badge/VSCode-blue?style=flat&logo=VisualStudioCode)&nbsp;![github](https://img.shields.io/badge/github-606060?style=fat&logo=github)&nbsp;

- Windows11
- Visual Studio Code
- GitHub

## 사용 기술

![Flutter](https://img.shields.io/badge/Flutter-3.10.4-blue?style=flat&logo=flutter)

![Socket.io](https://img.shields.io/badge/Scket.io-black?style=flat&logo=Socket.io)&nbsp;![node.js](https://img.shields.io/badge/Node.js-18.14-339933?style=flat&logo=node.js)&nbsp;![express](https://img.shields.io/badge/express-grey?style=flat&logo=express)

![mysql](https://img.shields.io/badge/MySQL-grey?style=flat&logo=mysql)

![ec2](https://img.shields.io/badge/AWS-ec2-FF8C00?style=flat&logo=amazonec2)

**프론트엔드**

- Flutter

**백엔드**

- Socket.io
- Node.js
- Express

**데이터베이스**

- Mysql

**인프라**

- AWS EC2

## 프로젝트 목적

Flutter를 활용한 앱 개발 및 출시와 Socket.io를 경험해보는 것을 목적으로 프로젝트를 진행하였습니다.<br>

## 화면 구성💻

### 모바일 화면📱

| ![방목록](https://github.com/YoungJunKim-Dev/swith/assets/114643395/2ae0f3ff-45a1-4597-94a5-324f3a9a592e) | ![채팅](https://github.com/YoungJunKim-Dev/swith/assets/114643395/1705333a-1b87-4f5d-9f58-7bec8f7169db) | ![로그인](https://github.com/YoungJunKim-Dev/swith/assets/114643395/4f8e11ae-cb1d-4bff-976b-37bc1ace66fa) | ![회원가입](https://github.com/YoungJunKim-Dev/swith/assets/114643395/06a85a78-9752-4631-896c-fb822a936076) |
| :-------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------: |
|                                                  방목록                                                   |                                                  채팅                                                   |                                                  로그인                                                   |                                                  회원가입                                                   |

| ![방만들기](https://github.com/YoungJunKim-Dev/swith/assets/114643395/b81de395-41e5-4d46-94d8-6a839363f6d0) | ![필터 옵션](https://github.com/YoungJunKim-Dev/swith/assets/114643395/c75d38fa-b5fd-4ff2-9b52-a034c1c6cb20) | ![입장](https://github.com/YoungJunKim-Dev/swith/assets/114643395/70e1112d-1eb1-4bd3-8e2a-62b38446348c) | ![회원탈퇴](https://github.com/YoungJunKim-Dev/swith/assets/114643395/6b1136a0-13fa-45cc-a11b-ac3fad45592c) |
| :---------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------: |
|                                                  방 만들기                                                  |                                                   필터옵션                                                   |                                                  입장                                                   |                                                  회원탈퇴                                                   |

<br>

## 핵심 기능⭐

### 🌠방(Room)

&ensp;&ensp;**방 목록**

<div align="center">
 <img src="https://github.com/YoungJunKim-Dev/swith/assets/114643395/311a42fd-4287-46cc-8a05-964312db66a7" width="200""/>
</div>

- 로그인 후 가장 첫 화면이 방목록 화면입니다.
- 현재 생성되어 있는 방들을 확인할 수 있고, 방 제목, 방 생성자, 방의 타입 등을 확인하고 선택할 수 있습니다.
- 아래로 당기는 스크롤을 통해 새로고침을 할 수 있습니다.
  - 다만, 존재하는 방이 없을 경우에는 상단에 새로고침 버튼을 클릭하여 새로고침합니다.
- 필터 옵션을 추가하여 내가 원하는 타입의 방들만 선별하여 볼 수 있습니다.
- 방을 클릭하면 입장할 수 있습니다. 비공개방일 경우 비밀번호 모달창이 뜨고 비밀번호가 일치해야만 입장할 수 있습니다.

<br>

&ensp;&ensp;**방 생성**

<div align="center">
<img src="https://github.com/YoungJunKim-Dev/swith/assets/114643395/2521c931-9d95-4195-9031-d6059cb8bc33" width="200"/></div>
<br>

- 초기화면인 방 목록 화면에서 방 만들기 버튼을 클릭하면 bottom sheet이 올라오고 방의 제목, 타입 선택, 비밀번호 생성 등의 기능등을 통하여 새로운 방을 생성할 수 있습니다.

<br>

&ensp;&ensp;**방 필터**

<div align="center">
<img src="https://github.com/YoungJunKim-Dev/swith/assets/114643395/f3d24a59-85f8-49ad-b35a-4a552100075f" width="200"/>
</div>

- 초기화면인 방 목록 화면에서 우측 상단의 필터 아이콘을 클릭하면 모달 창이 팝업되고 원하는 방 타입을 선택하여 원하는 방만 볼 수 있습니다.

### 🌠채팅(Chat)

Socket.io를 사용하여 일반 채팅방을 구현하였습니다. 초기에는 일반채팅방(채팅만 가능)과 영상채팅방(영상 + 채팅 가능)을 모두 구현하는 것으로 계획하고 프로젝트를 시작하였으나 영상채팅방 구현의 어려움들로 인해 영상채팅 기능은 추후에 추가하는 것으로 계획을 수정하였습니다.

<br>

&ensp;&ensp;**일반 채팅**

<div align="center">
<img src="https://github.com/YoungJunKim-Dev/swith/assets/114643395/7727e8c6-4da2-4210-9fd1-518c23fe0e79" width="200"/>
</div>

- 내가 입장해있는 상태에서 상대방이 방에 입장하게 되면 입장 알림 메세지가 표시됩니다.
- 메세지를 전송하면 나의 메세지는 분홍색 버블에 오른쪽에 생기고, 상대방의 메세지는 회색 버블로 왼쪽에 생깁니다.
- 분단위로 시간이 바뀔때만 시간을 보여줍니다.
- 상대방의 메세지가 연속될 경우 첫 메세지에만 상단에 이름을 표시해줍니다.
- 상대방이 방을 떠나게 되면 퇴장 알림 메세지가 표시됩니다.
- 방에 남아있는 인원이 아무도 없게 되면 방은 사라지고, 방 목록에서 조회해도 보이지 않습니다.

<br>

&ensp;&ensp;**영상 채팅**

- null

### 🌠회원(Users)

&ensp;&ensp;**로그인**

<div align="center">
<img src="https://github.com/YoungJunKim-Dev/swith/assets/114643395/ca785e7e-f834-413a-8be6-f59378bae32b" width="200"/>
</div>

- 로그인 시도시 1차적으로 입력된 email로 회원이 존재하는지 확인합니다. 그 다음으로 email이 존재한다면 입력된 비밀번호와 DB에 저장된 회원정보의 비밀번호 해시값이랑 비교합니다.
- 존재하는 email로 로그인을 시도하고 비밀번호가 일치한다면 JWT 토큰을 발행합니다. JWT 토큰은 FlutterSecureStorage에 저장되도록 하였습니다.
- 자동 로그인 기능은 JWT 토큰이 저장되어 있는지 저장되어 있다면 그 토큰이 유효한지에 따라 로그인 화면으로 이동할지 방목록 화면으로 이동할지 달라집니다. Server에서는 passport모듈의 JWT Strategy를 사용하여 Authorization 절차를 수행합니다.

<br>

&ensp;&ensp;**회원가입**

<div align="center">
<img src="https://github.com/YoungJunKim-Dev/swith/assets/114643395/2533cca9-4bc4-4d0d-a2ab-f25f70988906" width="200"/>
</div>

- 회원가입 신청 시 서버에서 중복되는 이메일이 있는지 확인을 하고, 이미 존재하는 이메일로 가입 시도 시 에러 메시지를 통해 유저가 인지할 수 있습니다.
- 회원가입시 비밀번호는 bcrypt를 이용하여 해시 암호화를 적용하고 해시값을 DB에 저장하였습니다.

<br>

&ensp;&ensp;**회원탈퇴**

<div align="center">
<img src="https://github.com/YoungJunKim-Dev/swith/assets/114643395/05677bb2-9cce-488d-9bd8-dde155f1ab25" width="200"/>
</div>

- 회원탈퇴를 위해 이메일과 비밀번호를 한번 더 확인한 후에 탈퇴가 가능하도록 하였습니다.
