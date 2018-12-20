# alert-module
 - alert-form.tpl


## Step 1: Add the Form

Create a calendar for Alerts and upload the following form 

```
<script>
  $(function() {
    $("#alert_destination").change(function() {
      if ($(this).val() == "External Link") {
        $('#external').show();
        $('#internal').hide();
      } else if ($(this).val() == "Internal Link") {
        $('#internal').show();
        $('#external').hide();
      } else {
        $('#external').hide();
        $('#internal').hide();
      }
    });

    $("#alert_destination").trigger("change");

  });
</script>

<div class="panel-group">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" href="#collapseStatus" aria-expanded="true">Post Status<span class="toggle"aria-hidden="true"></span></a>
      </h4>
    </div>
    <div id="collapseStatus" class="panel-collapse collapse in">
      <div class="panel-body">
        <div class="row">
          <div class="col-md-3">
            <h2><label class="label-control" for="post_status">Post Status</label></h2>
            <select class="form-control" type="text" name="post_status">
              <option value="Draft">Draft</option>
              <option value="Published">Published</option>
            </select>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="panel-group">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" href="#collapseContent" aria-expanded="true">Alerts Content <span class="toggle" aria-hidden="true"></span></a>
      </h4>
    </div>
    <div id="collapseContent" class="panel-collapse collapse in">
      <div class="panel-body">
        <div class="row">
          <div class="col-md-6">
            <h2><label class="label-control" for="alert_destination">Alert Link Destination</label></h2>
            <p class="subText">(Optional)</p>
            <select class="form-control" name="alert_destination" id="alert_destination">
              <option value="None">None</option>
              <option value="Internal Link">Internal Link</option>
              <option value="External Link">External Link</option>
            </select>
          </div>
          <div class="col-md-6" id="internal">
            <h2><label class="label-control" for="internal_link">Internal Link URL</label></h2>
            <p class="subText">(Required - If Alert Link Destination is set)</p>
            <input type="text" class="form-control" name="internal_link" id="internal_link">
          </div>
          <div class="col-md-6" id="external">
            <h2><label class="label-control" for="external_link">External Link URL</label></h2>
            <p class="subText">(Required - If Alert Link Destination is set)</p>
            <input type="text" class="form-control" name="external_link" id="external_link">
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <h2><label class="label-control" for="alert_text">Alert Text</label></h2>
            <p class="subText">(Required)</p>
            <textarea class="form-control" name="alert_text" id="alert_text"></textarea>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<div class="panel-group">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" href="#collapseAdvanced">Advanced <span class="toggle" aria-hidden="true"></span></a>
      </h4>
    </div>
    <div id="collapseAdvanced" class="panel-collapse collapse">
      <div class="panel-body">
        <div class="row">
          <div class="col-md-12">
            <h2><label class="label-control" for="post_javascript">Custom JavaScript</label></h2>
            <p class="subText">(Optional) Use the following textbox to embed any custom JavaScript including tracking pixels and Google Analytics scripts. Be sure to open your JavaScript with a &lt;script&gt; tag and close everything with a &lt;/script&gt; tag.</p>
            <textarea class="form-control" name="post_javascript" id="post_javascript"></textarea>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
```

## Step 2: Add the Repeater
 - alert-repeater.tpl

Add the following repeater shortcode. Since users will see this alert on all pages until they close it, it is best to include it in a template that is used throughout the site.

```


[repeater id='14' limit="0,1" display_type="news" where="post_status='Published'"]
  <div id="top-alert-bar" class="w-100 bg-secondary text-center">
    <div class="container position-relative py-3">
      [cond type="is" subject="{{alert_destination}}" value="Internal Link"]
      <a class="text-white h5" href="/{{internal_link}}">
        <strong>{{alert_text}}</strong>
      </a>
      [/cond]
      [cond type="is" subject="{{alert_destination}}" value="External Link"]
      <a class="text-white h5" href="{{external_link}}" target="_blank">
        <strong>{{alert_text}}</strong>
      </a>
      [/cond]

      [cond type="is" subject="{{alert_destination}}" value="None"]
      <p class="text-white h5 mb-0"><strong>{{alert_text}}</strong></p>
      [/cond]
      
      <div class="position-absolute top-0 right-0 d-flex align-items-center h-100">
        <i id="alert-close" class="pointer fas fa-times text-white mr-3"></i>
      </div>
    </div>
 </div>
 <!-- If there is custom JS within your Alert -->
 {{post_javascript}}
[/repeater]
```

## Step 3: Add the Following JavaScript
- /_/js/alert-bar.js

Add the JS to make sure the alert doesnt appear again onced closed.


```
/** ===========================================
  Alert Module
============================================ */

document.addEventListener("DOMContentLoaded", function (evt) {
    // Alert Bar Trigger if Not Closed
    var alertBar = document.getElementById('top-alert-bar');
    var alertBarAccept = document.getElementById('alert-close');
    if(alertBar) {
      if (!localStorage.alertClosed) {
          alertBar.style.display = "inherit";
      } else {
          alertBar.style.display = "none";
      }
    }
    if(alertBarAccept) {
        alertBarAccept.onclick = function () {
            alertBar.style.display = "none";
            localStorage.alertClosed = 'true';
        };
	}
    if (navigator.userAgent.match(/Opera|OPR\//) && alertBar) {
        alertBar.style.display = "inherit";
    }
});

```
