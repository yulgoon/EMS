from django.shortcuts import render
from .models import Board
from django.utils import timezone
from django.http import HttpResponseRedirect
from django.core.paginator import Paginator
import traceback # 실행 예외의 메세지 출력
# board/views.py
# Create your views here.

def write(request):
    if request.method != "POST":
        return render(request, "board/write.html")
    else:
        try:
            # request.FILES["file1"]의 내용(첨부파일)이 없는 경우 예외 발생
            filename = request.FILES['file1'].name
            # handle_upload(request.FILES['file1']): 첨부파일이 있는 경우만 실행 됨
            handle_upload(request.FILES['file1'])
        except:
            filename = ''
    # settings.py => USE_TZ=False로 해야 현지 시간으로 처리 됨
        b= Board(name=request.POST['name'],\
           pw=request.POST['pw'],\
           title=request.POST['title'],\
           content=request.POST['content'],\
           regdate=timezone.now(),\
           readcnt=0, file1=filename
           )
        b.save()
        return HttpResponseRedirect("../list")
        
def handle_upload(f):
    #업로드 위치: BASE_DIR/file/board/ 폴더
    with open('file/board/'+f.name, 'wb') as dest:
        for ch in f.chunks():
            dest.write(ch)
            
def list(request):
    # get방식에서 전달받은 pageNum param 값
    # pageNum param가 없는 경우 1로 설정
    pageNum = int(request.GET.get('pageNum', 1))
    # Board.objects.all(): board 테이블의 모든 정보 조회
    # order_by('num'): num 컬럼의 오름차순 조회 => 1 2 3 4 5
    # order_by('-num'): num 컬럼의 내림차순 조회 => 5 4 3 2 1
    all_boards = Board.objects.all().order_by('-num') # '-num' columns의 내림차순(가장 최근 등록된 게시물(레코드)부터 역차 게시)
    # 10씩 묶어서 그룹화 함
    paginator = Paginator(all_boards, 10)
    # board_list: 조회하는 pageNum번째의 게시글 목록 저장, 화면에 출력할 게시물 목록
    board_list = paginator.get_page(pageNum)
    listcount = Board.objects.count() # 등록된 레코드 건 수
    return render(request, "board/list.html", {"board":board_list, "listcount":listcount})

def info(request, num):
    board = Board.objects.get(num=num)  # num 값에 해당하는 게시물 한 건 조회
    board.readcnt += 1                  # 조회 건 수 1 증가
    board.save()                        # 게시물 수정, 조회 건 수 1 증가되어 저장 됨
    return render(request,"board/info.html",{"b":board})

# 게시물 수정하기
def update(request, num):
    if request.method != 'POST':
        board = Board.objects.get(num=num)
        return render(request, 'board/update.html',{'b': board})
    else :
        # 비밀번호 검증
        board = Board.objects.get(num=num)
        pw = request.POST["pw"] # 입력된 비밀 번호
        if board.pw != pw :
            context = {"msg":"비밀번호 오류","url":"../../update/"+str(num) + "/"}
            return render(request,"alert.html",context)
        
        # 비밀번호 동일
        try :
            # 업로드된 파일 이름, 업로드가 안 된 경우 오류
            filename = request.FILES["file1"].name
            handle_upload(request.FILES["file1"])
        except :
            filename = ""
        # filename 결정
        try :
            if filename == "" :
               filename = request.POST["file2"] # 수정 전 업로드 파일의 이름 설정
            b=Board(num=num,\
                    name=request.POST["name"],\
                    pw=request.POST["pw"],\
                    title=request.POST["title"],\
                    content=request.POST["content"],\
                    file1=filename)   
            b.save()    # 수정
            return HttpResponseRedirect("../../list/")
        except Exception as e :
            print(traceback.format_exc()) # runserver 콘솔창에 오류 메세지 출력
            context = {"msg":"게시물 수정 실패",\
                       "url":"../../update/"+str(num) + "/"}
            return render(request,"alert.html",context)
            
# 게시물 삭제하기
def delete (request, num):
    if request.method != 'POST':
        return render(request, 'board/delete.html',{"num":num})
    else :
        # 비밀번호 검증
       b=Board.objects.get(num=num)
       pw = request.POST["pw"]
       if pw != b.pw :  # 입력된 비밀번호와 DB 비밀번호 비교
          context = {"msg":"비밀번호 오류",\
                       "url":"../../delete/"+str(num) + "/"}
          return render(request,"alert.html",context)
      # 비밀번호가 일치하는 경우
       try :
          b.delete()
          return HttpResponseRedirect("../../list/")
      # 비밀번호가 틀린 경우
       except :
          print(traceback.format_exc()) #runserver 콘솔창에 오류 메세지 출력
          context = {"msg":"게시물 삭제 실패",\
                       "url":"../../delete/"+str(num) + "/"}
          return render(request,"alert.html",context)