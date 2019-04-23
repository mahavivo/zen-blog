% rebase('base.tpl', title='Page Title')

<div class="card mb-3">

  <img class="card-img-top" src="http://www.bing.com/th?id=OHR.SakuraFes_EN-CA2063659121_1920x1080.jpg&rf=NorthMale_1920x1080.jpg&pid=hp" alt="Card image cap">
  <div class="card-block">
    <h4 class="card-title text-center" style="margin:32px;">{{post['title']}}</h4>
    <p class="card-text">{{post['content']}}</p>
    <p class="card-text text-muted text-right">{{post['date']}}</p>
  </div>

</div>
