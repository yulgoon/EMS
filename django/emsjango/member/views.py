from django.shortcuts import render
from .models import Member
from django.http import HttpResponseRedirect
from django.contrib import auth
from deco.deco import loginIdchk,adminChk,loginchk
# Create your views here.
# member/views.py 
# request : 요청객체. 요청정보를 저장

# http://localhost:8000/member/join 요청시 호출되는 함수
def join(request): 
    if request.method != 'POST':
       # /templates/member/join.html => Template파일임.
       return render(request,"member/join.html")
    else :  # post 방식 요청 => 파라미터 존재
       member = Member(id=request.POST["id"],\
                  pw=request.POST["pw"],\
                  name=request.POST["name"],\
                  gender=request.POST["gender"],    
                  tel=request.POST["tel"],\
                  email=request.POST["email"],\
                  picture=request.POST["picture"])
       member.save() #insert 구문 실행.
#HttpResponseRedirect :브라우저에서 login url을 재요청하도록 명령함
       return HttpResponseRedirect("../login/")
           
def login(request):
    if request.method != 'POST':
       return render(request,"member/login.html")
    else :
       id=request.POST["id"]
       pw=request.POST["pw"]
       try :
           #Member.objects.get(id=id) : id파라미터의 값에 해당하는
           #   member 객체를 조회.
           #(Member.id=파라미터id)
           member = Member.objects.get(id=id) 
       except : #예외 발생. 파라미터id값에 대한 정보가 db에 없을때
           context={"msg":"아이디를 확인하세요"}
           return render(request,"member/login.html",context)
       else :  #정상처리. 파라미터id값에 대한 정보가 db에 존재함.조회됨
           # db에저장된비밀번호 와 입력된비밀번호 검증
           if member.pw == pw : #정상로그인
              request.session["login"] = id
              return HttpResponseRedirect("../main/")
           else :   #비밀번호 틀림
              context={"msg":"비밀번호가 틀립니다"}
              return render(request,"member/login.html",context)

def main(request):
    return render(request,"member/main.html")

def logout(request):
    auth.logout(request) #session 정보 제거
    return HttpResponseRedirect("../login/")
'''
1. 로그인된 경우.
2. 내정보만 조회가능.단 admin은 다른회원 정보 조회가능

1+2 조건을 모두 만족하는 경우만 조회 가능하도록 수정하기
'''
@loginIdchk
def info(request,id) :  #id:admin 또는 hongkd, 아이디값
#1+2 조건 만족한 경우만 실행
    member = Member.objects.get(id=id)
    return render(request,"member/info.html",{"mem":member})

'''
  1. 로그인 필수
  2. admin 으로 로그인되어야 함.
  
  1+2 조건을 모두 만족 해야함.
'''
@adminChk
def list(request) :  
    mlist = Member.objects.all() #모든 회원 목록 정보 조회
    return render(request,"member/list.html",{"mlist":mlist})

def picture(request) :
    if request.method != 'POST':
        return render(request,"member/pictureform.html")
    else: #파일 업로드 실행
        # request.FILES['picture'].name => 업로드 된 파일의 내용
        fname = request.FILES['picture'].name #템플릿 pictureform의 name=picture인 것을 가져 옴 => .name: 업로드 된 파일의 이름 의미
        handle_upload(request.FILES['picture'])
        return render(request,'member/picture.html',{'fname':fname})
    
# BASE_DIR/file/picture 폴더 생성하기 => 업로드 되는 폴더
def handle_upload(f): #f: 파일의 내용
# wb: 모드
#   w: write
#   b: binary
# f.name: 파일이름
# dest: 생성될 파일(출력 스트림)
# file/picture/파일이름 => 파일 생성, BASE_DIR/file/picture 폴더에 생성
    with open('file/picture/'+f.name,'wb') as dest:
        # f.chanks(): 버퍼의 크기만큼 2진 파일을 읽어서 ch에 담음
        for ch in f.chunks():
            dest.write(ch)
            
@loginIdchk
def update(request, id):
    if request.method != "POST": 
        member = Member.objects.get(id=id) #수정할 데이터를 조회
        return render(request,"member/update.html",{"mem":member})
    else:
        mem = Member.objects.get(id=id)
        if request.POST["pw"] == mem.pw:
            member = Member(id=request.POST["id"],\
                            pw=request.POST["pw"],\
                            name=request.POST["name"],\
                            gender=request.POST["gender"],\
                            tel=request.POST["tel"],\
                            email=request.POST["email"],\
                            picture=request.POST["picture"]
                            )
                    #id값 존재: update, id값 없으면 insert
            member.save() #update 문장 실행
            return HttpResponseRedirect("../../info/"+id+"/")
        else:
            context = {"msg":"비밀번호 오류입니다.","url":"../../update/"+id+"/"}
            return render(request,"alert.html",context)
        

'''
          비밀번호 검증                           탈퇴 성공
본인탈퇴:  본인의 비밀번호(회원 스스로 탈퇴 시킴)      로그아웃, 로그인화면 출력
강제탈퇴:  관리자의 비밀번호(관리자가 회원 탈퇴시킴)    로그아웃x, 회원목록 출력
'''
@loginIdchk
def delete(request, id):
    if request.method != "POST":
        if id == 'admin':
            context={"msg":"관리자는 탈퇴 불가입니다.","url":"../../list/"}
            return render(request,"alert.html",context)
        return render(request,"member/delete.html",{"id":id})
    else:
        login = request.session["login"] #관리자로 로그인하면 현재 로그인한 사용자(관리자)의 비밀번호를 검증
        #member: 로그인한 회원의 정보
        member = Member.objects.get(id=login)
        #비밀번호 일치 시,
        if member.pw == request.POST["pw"]:
            mem = Member.objects.get(id=id)
            mem.delete() #mem: 탈퇴해야 하는 회원정보, delete 됨
            if id == login: #본인 탈퇴
                auth.logout(request)
                context={"msg":"회원 탈퇴가 완료되었습니다.","url":"../../login/"}
                return render(request, "alert.html", context)
            else: #관리자 강제탈퇴
                context={"msg":"회원 탈퇴가 완료되었습니다.","url":"../../list/"}
                return render(request, "alert.html", context)
        #비밀번호 불일치 시,
        else:
            context={"msg":"비밀번호 오류","url":"../../delete/"+id+"/"}
            return render(request, "alert.html", context)

@loginchk #로그인 되어 있으면 password() 실행, 아니면 미실행
def password(request):
    if request.method != "POST":
        return render(request,"member/passwordform.html")
    else:
# 입력된 비밀번호(현재 비밀번호), DB의 비밀번호 검증
        login = request.session['login']
        member = Member.objects.get(id=login)
        if member.pw == request.POST['pw']:
            member.pw = request.POST['chgpw']
            member.save()
            context={"msg":"비밀번호 변경 성공","url":"../info/"+login+"/", "closer":True}
            return render(request, "member/password.html", context)
        else:
            context={"msg":"비밀번호 오류","url":"../password/", "closer":False}
            return render(request, "member/password.html", context)
                
'''
python manage.py startapp board => board app(폴더) 생성: 게시판 app
'''
