% rebase('base.tpl', title='Page Title')

<br>


%if len(posts) < 1:
   <h3 class="text-center"> No blog post at the moment, check back later... </h3>
%end

%for post in posts:
    <div class="card border-0">

      <div class="card-block" style="font-family:PingFangSC,Arial,'Hiragino Sans GB';">

        <div class="card-text text-muted">
        {{post['date'][0:10]}} <a href="/post/{{post['id']}}"><span style="font-size:16px; margin-left:20px">{{post['title']}}</span></a>
        </div>

      </div>
    </div> <br>
%end