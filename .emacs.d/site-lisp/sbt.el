
    

  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
        <title>tools/emacs/sbt.el at master from RayRacine's scallap - GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="http://github.com/fluidicon.png" title="GitHub" />

    <link href="http://assets3.github.com/stylesheets/bundle_common.css?d41521c484ad471778ea43ccfb07421d5ddb1942" media="screen" rel="stylesheet" type="text/css" />
<link href="http://assets2.github.com/stylesheets/bundle_github.css?d41521c484ad471778ea43ccfb07421d5ddb1942" media="screen" rel="stylesheet" type="text/css" />

    <script type="text/javascript" charset="utf-8">
      var GitHub = {}
      var github_user = null
      
    </script>
    <script src="http://assets1.github.com/javascripts/jquery/jquery-1.4.2.min.js?d41521c484ad471778ea43ccfb07421d5ddb1942" type="text/javascript"></script>
    <script src="http://assets1.github.com/javascripts/bundle_common.js?d41521c484ad471778ea43ccfb07421d5ddb1942" type="text/javascript"></script>
<script src="http://assets1.github.com/javascripts/bundle_github.js?d41521c484ad471778ea43ccfb07421d5ddb1942" type="text/javascript"></script>

        <script type="text/javascript" charset="utf-8">
      GitHub.spy({
        repo: "RayRacine/scallap"
      })
    </script>

    
  
    
  

  <link href="http://github.com/RayRacine/scallap/commits/master.atom" rel="alternate" title="Recent Commits to scallap:master" type="application/atom+xml" />

        <meta name="description" content="Scala Enterprise Edition - OSGi Framwork for Scala Applications, Modules and Services." />
    <script type="text/javascript">
      GitHub.nameWithOwner = GitHub.nameWithOwner || "RayRacine/scallap";
      GitHub.currentRef = 'master';
    </script>
  

            <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-3769691-2']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script');
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        ga.setAttribute('async', 'true');
        document.documentElement.firstChild.appendChild(ga);
      })();
    </script>

  </head>

  

  <body class="logged_out ">
    

    
      <script type="text/javascript">
        var _kmq = _kmq || [];
        function _kms(u){
          var s = document.createElement('script'); var f = document.getElementsByTagName('script')[0]; s.type = 'text/javascript'; s.async = true;
          s.src = u; f.parentNode.insertBefore(s, f);
        }
        _kms('//i.kissmetrics.com/i.js');_kms('//doug1izaerwt3.cloudfront.net/406e8bf3a2b8846ead55afb3cfaf6664523e3a54.1.js');
      </script>
    

    

    

    

    <div class="subnavd" id="main">
      <div id="header" class="true">
        
          <a class="logo boring" href="http://github.com">
            <img src="/images/modules/header/logov3.png?changed" class="default" alt="github" />
            <![if !IE]>
            <img src="/images/modules/header/logov3-hover.png" class="hover" alt="github" />
            <![endif]>
          </a>
        
        
        <div class="topsearch">
  
    <ul class="nav logged_out">
      <li><a href="http://github.com">Home</a></li>
      <li class="pricing"><a href="/plans">Pricing and Signup</a></li>
      <li><a href="http://github.com/training">Training</a></li>
      <li><a href="http://gist.github.com">Gist</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="https://github.com/login">Login</a></li>
    </ul>
  
</div>

      </div>

      
      
        
    <div class="site">
      <div class="pagehead repohead vis-public   ">

      

      <div class="title-actions-bar">
        <h1>
          <a href="/RayRacine">RayRacine</a> / <strong><a href="http://github.com/RayRacine/scallap">scallap</a></strong>
          
          
        </h1>

        
    <ul class="actions">
      

      
        <li class="for-owner" style="display:none"><a href="https://github.com/RayRacine/scallap/edit" class="minibutton btn-admin "><span><span class="icon"></span>Admin</span></a></li>
        <li>
          <a href="/RayRacine/scallap/toggle_watch" class="minibutton btn-watch " id="watch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'b01ddca66df53fc16bd74e9bc7533e3707e3d46b'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Watch</span></a>
          <a href="/RayRacine/scallap/toggle_watch" class="minibutton btn-watch " id="unwatch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'b01ddca66df53fc16bd74e9bc7533e3707e3d46b'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Unwatch</span></a>
        </li>
        
          
            <li class="for-notforked" style="display:none"><a href="/RayRacine/scallap/fork" class="minibutton btn-fork " id="fork_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'b01ddca66df53fc16bd74e9bc7533e3707e3d46b'); f.appendChild(s);f.submit();return false;"><span><span class="icon"></span>Fork</span></a></li>
            <li class="for-hasfork" style="display:none"><a href="#" class="minibutton btn-fork " id="your_fork_button"><span><span class="icon"></span>Your Fork</span></a></li>
          

          
        
      
      
      <li class="repostats">
        <ul class="repo-stats">
          <li class="watchers"><a href="/RayRacine/scallap/watchers" title="Watchers" class="tooltipped downwards">10</a></li>
          <li class="forks"><a href="/RayRacine/scallap/network" title="Forks" class="tooltipped downwards">0</a></li>
        </ul>
      </li>
    </ul>

      </div>

        
  <ul class="tabs">
    <li><a href="http://github.com/RayRacine/scallap/tree/master" class="selected" highlight="repo_source">Source</a></li>
    <li><a href="http://github.com/RayRacine/scallap/commits/master" highlight="repo_commits">Commits</a></li>

    
    <li><a href="/RayRacine/scallap/network" highlight="repo_network">Network (0)</a></li>

    

    
      
      <li><a href="/RayRacine/scallap/issues" highlight="issues">Issues (0)</a></li>
    

                    
    <li><a href="/RayRacine/scallap/graphs" highlight="repo_graphs">Graphs</a></li>

    <li class="contextswitch nochoices">
      <span class="toggle leftwards" >
        <em>Branch:</em>
        <code>master</code>
      </span>
    </li>
  </ul>

  <div style="display:none" id="pl-description"><p><em class="placeholder">click here to add a description</em></p></div>
  <div style="display:none" id="pl-homepage"><p><em class="placeholder">click here to add a homepage</em></p></div>

  <div class="subnav-bar">
  
  <ul>
    <li>
      <a href="#" class="dropdown">Switch Branches (1)</a>
      <ul>
        
          
            <li><strong>master &#x2713;</strong></li>
            
      </ul>
    </li>
    <li>
      <a href="#" class="dropdown defunct">Switch Tags (0)</a>
      
    </li>
    <li>
    
    <a href="/RayRacine/scallap/branches" class="manage">Branch List</a>
    
    </li>
  </ul>
</div>

  
  
  
  
  
  



        
    <div id="repo_details" class="metabox clearfix">
      <div id="repo_details_loader" class="metabox-loader" style="display:none">Sending Request&hellip;</div>

        <a href="/RayRacine/scallap/downloads" class="download-source" id="download_button" title="Download source, tagged packages and binaries."><span class="icon"></span>Downloads</a>

      <div id="repository_desc_wrapper">
      <div id="repository_description" rel="repository_description_edit">
        
          <p>Scala Enterprise Edition - OSGi Framwork for Scala Applications, Modules and Services.
            <span id="read_more" style="display:none">&mdash; <a href="#readme">Read more</a></span>
          </p>
        
      </div>
      <div id="repository_description_edit" style="display:none;" class="inline-edit">
        <form action="/RayRacine/scallap/edit/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="b01ddca66df53fc16bd74e9bc7533e3707e3d46b" /></div>
          <input type="hidden" name="field" value="repository_description">
          <input type="text" class="textfield" name="value" value="Scala Enterprise Edition - OSGi Framwork for Scala Applications, Modules and Services.">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>

      
      <div class="repository-homepage" id="repository_homepage" rel="repository_homepage_edit">
        <p><a href="http://" rel="nofollow"></a></p>
      </div>
      <div id="repository_homepage_edit" style="display:none;" class="inline-edit">
        <form action="/RayRacine/scallap/edit/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="b01ddca66df53fc16bd74e9bc7533e3707e3d46b" /></div>
          <input type="hidden" name="field" value="repository_homepage">
          <input type="text" class="textfield" name="value" value="">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>
      </div>
      <div class="rule "></div>
            <div id="url_box" class="url-box">
        <ul class="clone-urls">
          
            
            <li id="http_clone_url"><a href="http://github.com/RayRacine/scallap.git" data-permissions="Read-Only">HTTP</a></li>
            <li id="public_clone_url"><a href="git://github.com/RayRacine/scallap.git" data-permissions="Read-Only">Git Read-Only</a></li>
          
        </ul>
        <input type="text" spellcheck="false" id="url_field" class="url-field" />
              <span style="display:none" id="url_box_clippy"></span>
      <span id="clippy_tooltip_url_box_clippy" class="clippy-tooltip tooltipped" title="copy to clipboard">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="14"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="http://assets0.github.com/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=url_box_clippy&amp;copied=&amp;copyto=">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="http://assets0.github.com/flash/clippy.swf?v5"
             width="14"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=url_box_clippy&amp;copied=&amp;copyto="
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      </span>

        <p id="url_description">This URL has <strong>Read+Write</strong> access</p>
      </div>
    </div>


        

      </div><!-- /.pagehead -->

      









<script type="text/javascript">
  GitHub.currentCommitRef = 'master'
  GitHub.currentRepoOwner = 'RayRacine'
  GitHub.currentRepo = "scallap"
  GitHub.downloadRepo = '/RayRacine/scallap/archives/master'
  GitHub.revType = "master"

  GitHub.controllerName = "blob"
  GitHub.actionName     = "show"
  GitHub.currentAction  = "blob#show"

  

  
</script>








  <div id="commit">
    <div class="group">
        
  <div class="envelope commit">
    <div class="human">
      
        <div class="message"><pre><a href="/RayRacine/scallap/commit/000e748597d9b73e2da026029afc4ca9248aa936">Simple EMACS support for SBT - Scala Build Tool</a> </pre></div>
      

      <div class="actor">
        <div class="gravatar">
          
          <img src="http://www.gravatar.com/avatar/954841ccdbae05d7fec9bad137ec7708?s=140&d=http%3A%2F%2Fgithub.com%2Fimages%2Fgravatars%2Fgravatar-140.png" alt="" width="30" height="30"  />
        </div>
        <div class="name"><a href="/RayRacine">RayRacine</a> <span>(author)</span></div>
        <div class="date">
          <abbr class="relatize" title="2009-07-19 08:36:55">Sun Jul 19 08:36:55 -0700 2009</abbr>
        </div>
      </div>

      

    </div>
    <div class="machine">
      <span>c</span>ommit&nbsp;&nbsp;<a href="/RayRacine/scallap/commit/000e748597d9b73e2da026029afc4ca9248aa936" hotkey="c">000e748597d9b73e2da0</a><br />
      <span>t</span>ree&nbsp;&nbsp;&nbsp;&nbsp;<a href="/RayRacine/scallap/tree/000e748597d9b73e2da026029afc4ca9248aa936" hotkey="t">662bc9397bcf762b3b77</a><br />
      
        <span>p</span>arent&nbsp;
        
        <a href="/RayRacine/scallap/tree/0ef684347dc1681a980cd2dab70434725db4e9c5" hotkey="p">0ef684347dc1681a980c</a>
      

    </div>
  </div>

    </div>
  </div>



  
    <div id="path">
      <b><a href="/RayRacine/scallap/tree/master">scallap</a></b> / <a href="/RayRacine/scallap/tree/master/tools">tools</a> / <a href="/RayRacine/scallap/tree/master/tools/emacs">emacs</a> / sbt.el       <span style="display:none" id="clippy_3637">tools/emacs/sbt.el</span>
      
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="http://assets0.github.com/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=clippy_3637&amp;copied=copied!&amp;copyto=copy to clipboard">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="http://assets0.github.com/flash/clippy.swf?v5"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=clippy_3637&amp;copied=copied!&amp;copyto=copy to clipboard"
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      

    </div>

    <div id="files">
      <div class="file">
        <div class="meta">
          <div class="info">
            <span class="icon"><img alt="Txt" height="16" src="http://assets2.github.com/images/icons/txt.png?d41521c484ad471778ea43ccfb07421d5ddb1942" width="16" /></span>
            <span class="mode" title="File Mode">100644</span>
            
              <span>107 lines (87 sloc)</span>
            
            <span>3.781 kb</span>
          </div>
          <ul class="actions">
            
              <li><a id="file-edit-link" href="#" rel="/RayRacine/scallap/file-edit/__ref__/tools/emacs/sbt.el">edit</a></li>
            
            <li><a href="/RayRacine/scallap/raw/master/tools/emacs/sbt.el" id="raw-url">raw</a></li>
            
              <li><a href="/RayRacine/scallap/blame/master/tools/emacs/sbt.el">blame</a></li>
            
            <li><a href="/RayRacine/scallap/commits/master/tools/emacs/sbt.el">history</a></li>
          </ul>
        </div>
        
  <div class="data type-scheme">
    
      <table cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <pre class="line_numbers"><span id="LID1" rel="#L1">1</span>
<span id="LID2" rel="#L2">2</span>
<span id="LID3" rel="#L3">3</span>
<span id="LID4" rel="#L4">4</span>
<span id="LID5" rel="#L5">5</span>
<span id="LID6" rel="#L6">6</span>
<span id="LID7" rel="#L7">7</span>
<span id="LID8" rel="#L8">8</span>
<span id="LID9" rel="#L9">9</span>
<span id="LID10" rel="#L10">10</span>
<span id="LID11" rel="#L11">11</span>
<span id="LID12" rel="#L12">12</span>
<span id="LID13" rel="#L13">13</span>
<span id="LID14" rel="#L14">14</span>
<span id="LID15" rel="#L15">15</span>
<span id="LID16" rel="#L16">16</span>
<span id="LID17" rel="#L17">17</span>
<span id="LID18" rel="#L18">18</span>
<span id="LID19" rel="#L19">19</span>
<span id="LID20" rel="#L20">20</span>
<span id="LID21" rel="#L21">21</span>
<span id="LID22" rel="#L22">22</span>
<span id="LID23" rel="#L23">23</span>
<span id="LID24" rel="#L24">24</span>
<span id="LID25" rel="#L25">25</span>
<span id="LID26" rel="#L26">26</span>
<span id="LID27" rel="#L27">27</span>
<span id="LID28" rel="#L28">28</span>
<span id="LID29" rel="#L29">29</span>
<span id="LID30" rel="#L30">30</span>
<span id="LID31" rel="#L31">31</span>
<span id="LID32" rel="#L32">32</span>
<span id="LID33" rel="#L33">33</span>
<span id="LID34" rel="#L34">34</span>
<span id="LID35" rel="#L35">35</span>
<span id="LID36" rel="#L36">36</span>
<span id="LID37" rel="#L37">37</span>
<span id="LID38" rel="#L38">38</span>
<span id="LID39" rel="#L39">39</span>
<span id="LID40" rel="#L40">40</span>
<span id="LID41" rel="#L41">41</span>
<span id="LID42" rel="#L42">42</span>
<span id="LID43" rel="#L43">43</span>
<span id="LID44" rel="#L44">44</span>
<span id="LID45" rel="#L45">45</span>
<span id="LID46" rel="#L46">46</span>
<span id="LID47" rel="#L47">47</span>
<span id="LID48" rel="#L48">48</span>
<span id="LID49" rel="#L49">49</span>
<span id="LID50" rel="#L50">50</span>
<span id="LID51" rel="#L51">51</span>
<span id="LID52" rel="#L52">52</span>
<span id="LID53" rel="#L53">53</span>
<span id="LID54" rel="#L54">54</span>
<span id="LID55" rel="#L55">55</span>
<span id="LID56" rel="#L56">56</span>
<span id="LID57" rel="#L57">57</span>
<span id="LID58" rel="#L58">58</span>
<span id="LID59" rel="#L59">59</span>
<span id="LID60" rel="#L60">60</span>
<span id="LID61" rel="#L61">61</span>
<span id="LID62" rel="#L62">62</span>
<span id="LID63" rel="#L63">63</span>
<span id="LID64" rel="#L64">64</span>
<span id="LID65" rel="#L65">65</span>
<span id="LID66" rel="#L66">66</span>
<span id="LID67" rel="#L67">67</span>
<span id="LID68" rel="#L68">68</span>
<span id="LID69" rel="#L69">69</span>
<span id="LID70" rel="#L70">70</span>
<span id="LID71" rel="#L71">71</span>
<span id="LID72" rel="#L72">72</span>
<span id="LID73" rel="#L73">73</span>
<span id="LID74" rel="#L74">74</span>
<span id="LID75" rel="#L75">75</span>
<span id="LID76" rel="#L76">76</span>
<span id="LID77" rel="#L77">77</span>
<span id="LID78" rel="#L78">78</span>
<span id="LID79" rel="#L79">79</span>
<span id="LID80" rel="#L80">80</span>
<span id="LID81" rel="#L81">81</span>
<span id="LID82" rel="#L82">82</span>
<span id="LID83" rel="#L83">83</span>
<span id="LID84" rel="#L84">84</span>
<span id="LID85" rel="#L85">85</span>
<span id="LID86" rel="#L86">86</span>
<span id="LID87" rel="#L87">87</span>
<span id="LID88" rel="#L88">88</span>
<span id="LID89" rel="#L89">89</span>
<span id="LID90" rel="#L90">90</span>
<span id="LID91" rel="#L91">91</span>
<span id="LID92" rel="#L92">92</span>
<span id="LID93" rel="#L93">93</span>
<span id="LID94" rel="#L94">94</span>
<span id="LID95" rel="#L95">95</span>
<span id="LID96" rel="#L96">96</span>
<span id="LID97" rel="#L97">97</span>
<span id="LID98" rel="#L98">98</span>
<span id="LID99" rel="#L99">99</span>
<span id="LID100" rel="#L100">100</span>
<span id="LID101" rel="#L101">101</span>
<span id="LID102" rel="#L102">102</span>
<span id="LID103" rel="#L103">103</span>
<span id="LID104" rel="#L104">104</span>
<span id="LID105" rel="#L105">105</span>
<span id="LID106" rel="#L106">106</span>
<span id="LID107" rel="#L107">107</span>
</pre>
          </td>
          <td width="100%">
            
              <div class="highlight"><pre><div class='line' id='LC1'><span class="c1">;; Support for running sbt in inferior mode.</span></div><div class='line' id='LC2'><br/></div><div class='line' id='LC3'><span class="p">(</span><span class="nf">eval-when-compile</span> <span class="p">(</span><span class="nf">require</span> <span class="ss">&#39;cl</span><span class="p">))</span></div><div class='line' id='LC4'><span class="p">(</span><span class="nf">require</span> <span class="ss">&#39;tool-bar</span><span class="p">)</span></div><div class='line' id='LC5'><span class="p">(</span><span class="nf">require</span> <span class="ss">&#39;compile</span><span class="p">)</span></div><div class='line' id='LC6'><br/></div><div class='line' id='LC7'><span class="p">(</span><span class="nf">defgroup</span> <span class="nv">sbt</span> <span class="nv">nil</span></div><div class='line' id='LC8'>&nbsp;&nbsp;<span class="s">"Run SBT REPL as inferior of Emacs, parse error messages."</span></div><div class='line' id='LC9'>&nbsp;&nbsp;<span class="nv">:group</span> <span class="ss">&#39;tools</span></div><div class='line' id='LC10'>&nbsp;&nbsp;<span class="nv">:group</span> <span class="ss">&#39;processes</span><span class="p">)</span></div><div class='line' id='LC11'><br/></div><div class='line' id='LC12'><span class="p">(</span><span class="nf">defconst</span> <span class="nv">sbt-copyright</span>    <span class="s">"Copyright (C) 2008 Raymond Paul Racine"</span><span class="p">)</span></div><div class='line' id='LC13'><span class="p">(</span><span class="nf">defconst</span> <span class="nv">sbt-copyright-2</span>  <span class="s">"Portions Copyright (C) Free Software Foundation"</span><span class="p">)</span></div><div class='line' id='LC14'><br/></div><div class='line' id='LC15'><span class="p">(</span><span class="nf">defconst</span> <span class="nv">sbt-version</span>      <span class="s">"0.02"</span><span class="p">)</span></div><div class='line' id='LC16'><span class="p">(</span><span class="nf">defconst</span> <span class="nv">sbt-author-name</span>  <span class="s">"Raymond Racine"</span><span class="p">)</span></div><div class='line' id='LC17'><span class="p">(</span><span class="nf">defconst</span> <span class="nv">sbt-author-email</span> <span class="s">"ray.racine@gamail.com"</span><span class="p">)</span></div><div class='line' id='LC18'><br/></div><div class='line' id='LC19'><span class="p">(</span><span class="nf">defconst</span> <span class="nv">sbt-legal-notice</span></div><div class='line' id='LC20'>&nbsp;&nbsp;<span class="s">"This is free software; you can redistribute it and/or modify it under the</span></div><div class='line' id='LC21'><span class="s">terms of the GNU General Public License as published by the Free Software</span></div><div class='line' id='LC22'><span class="s">Foundation; either version 2, or (at your option) any later version.  This is</span></div><div class='line' id='LC23'><span class="s">distributed in the hope that it will be useful, but without any warranty;</span></div><div class='line' id='LC24'><span class="s">without even the implied warranty of merchantability or fitness for a</span></div><div class='line' id='LC25'><span class="s">particular purpose.  See the GNU General Public License for more details.  You</span></div><div class='line' id='LC26'><span class="s">should have received a copy of the GNU General Public License along with Emacs;</span></div><div class='line' id='LC27'><span class="s">see the file `COPYING&#39;.  If not, write to the Free Software Foundation, Inc.,</span></div><div class='line' id='LC28'><span class="s">59 Temple Place, Suite 330, Boston, MA 02111-1307, USA."</span><span class="p">)</span></div><div class='line' id='LC29'><br/></div><div class='line' id='LC30'><span class="p">(</span><span class="nf">defgroup</span> <span class="nv">sbt</span> <span class="nv">nil</span></div><div class='line' id='LC31'>&nbsp;&nbsp;<span class="s">"Support for sbt build REPL."</span></div><div class='line' id='LC32'>&nbsp;&nbsp;<span class="nv">:group</span>  <span class="ss">&#39;sbt</span></div><div class='line' id='LC33'>&nbsp;&nbsp;<span class="nv">:prefix</span> <span class="s">"sbt-"</span><span class="p">)</span></div><div class='line' id='LC34'><br/></div><div class='line' id='LC35'><span class="p">(</span><span class="nf">defcustom</span> <span class="nv">sbt-program-name</span> <span class="s">"sbt"</span></div><div class='line' id='LC36'>&nbsp;&nbsp;<span class="s">"Program invoked by the `run-sbt&#39; command."</span></div><div class='line' id='LC37'>&nbsp;&nbsp;<span class="nv">:type</span> <span class="ss">&#39;string</span></div><div class='line' id='LC38'>&nbsp;&nbsp;<span class="nv">:group</span> <span class="ss">&#39;sbt</span><span class="p">)</span></div><div class='line' id='LC39'><br/></div><div class='line' id='LC40'><span class="p">(</span><span class="nf">defun</span> <span class="nv">sbt-build-buffer-name</span> <span class="p">(</span><span class="nf">mode</span><span class="p">)</span></div><div class='line' id='LC41'>&nbsp;<span class="s">"*Scala Build Tool*"</span><span class="p">)</span></div><div class='line' id='LC42'><br/></div><div class='line' id='LC43'><span class="p">(</span><span class="nf">defun</span> <span class="nv">sbt-shell</span> <span class="p">()</span></div><div class='line' id='LC44'>&nbsp;&nbsp;<span class="s">"Launch the sbt shell."</span></div><div class='line' id='LC45'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">interactive</span><span class="p">)</span></div><div class='line' id='LC46'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">compile</span> <span class="p">(</span><span class="nf">concat</span> <span class="s">"cd "</span> <span class="p">(</span><span class="nf">sbt-find-path-to-project</span><span class="p">)</span> <span class="s">"; sbt"</span><span class="p">)</span> <span class="nv">t</span><span class="p">)</span></div><div class='line' id='LC47'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">pop-to-buffer</span> <span class="p">(</span><span class="nf">sbt-build-buffer-name</span> <span class="nv">nil</span><span class="p">))</span></div><div class='line' id='LC48'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">end-of-buffer</span><span class="p">))</span></div><div class='line' id='LC49'><br/></div><div class='line' id='LC50'><span class="p">(</span><span class="nf">defun</span> <span class="nv">sbt-clear</span> <span class="p">()</span></div><div class='line' id='LC51'>&nbsp;&nbsp;<span class="s">"Clear (erase) the SBT buffer."</span></div><div class='line' id='LC52'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">interactive</span><span class="p">)</span></div><div class='line' id='LC53'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">with-current-buffer</span> <span class="p">(</span><span class="nf">sbt-build-buffer-name</span> <span class="nv">nil</span><span class="p">)</span></div><div class='line' id='LC54'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="k">let </span><span class="p">((</span><span class="nf">inhibit-read-only</span> <span class="nv">t</span><span class="p">))</span></div><div class='line' id='LC55'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">erase-buffer</span><span class="p">))))</span></div><div class='line' id='LC56'><br/></div><div class='line' id='LC57'><span class="p">(</span><span class="nf">customize-set-variable</span> <span class="ss">&#39;scala-compile-error-regex</span>  </div><div class='line' id='LC58'>			<span class="o">&#39;</span><span class="p">(</span><span class="s">"^\\[error\\] \\([.a-zA-Z0-9/-]+[.]scala\\):\\([0-9]+\\):"</span> <span class="mi">1</span> <span class="mi">2</span> <span class="nv">nil</span> <span class="mi">2</span> <span class="nv">nil</span><span class="p">))</span>  </div><div class='line' id='LC59'><span class="p">(</span><span class="nf">customize-set-variable</span> <span class="ss">&#39;compilation-buffer-name-function</span> <span class="ss">&#39;sbt-build-buffer-name</span><span class="p">)</span>  </div><div class='line' id='LC60'><span class="p">(</span><span class="nf">customize-set-variable</span> <span class="ss">&#39;compilation-error-regexp-alist</span> <span class="p">(</span><span class="nb">list </span><span class="nv">scala-compile-error-regex</span><span class="p">))</span></div><div class='line' id='LC61'><span class="p">(</span><span class="nf">customize-set-variable</span> <span class="ss">&#39;compilation-mode-font-lock-keywords</span></div><div class='line' id='LC62'>			<span class="o">&#39;</span><span class="p">((</span><span class="s">"^\\[error\\] Error running compile:"</span></div><div class='line' id='LC63'>			   <span class="p">(</span><span class="mi">0</span> <span class="nv">compilation-error-face</span><span class="p">))</span></div><div class='line' id='LC64'>			  <span class="p">(</span><span class="s">"^\\[warn\\][^\n]*"</span></div><div class='line' id='LC65'>			   <span class="p">(</span><span class="mi">0</span> <span class="nv">compilation-warning-face</span><span class="p">))</span></div><div class='line' id='LC66'>			  <span class="p">(</span><span class="s">"^\\(\\[info\\]\\)\\([^\n]*\\)"</span></div><div class='line' id='LC67'>			   <span class="p">(</span><span class="mi">0</span> <span class="nv">compilation-info-face</span><span class="p">)</span></div><div class='line' id='LC68'>			   <span class="p">(</span><span class="mi">1</span> <span class="nv">compilation-line-face</span><span class="p">))</span></div><div class='line' id='LC69'>			  <span class="p">(</span><span class="s">"^\\[success\\][^\n]*"</span></div><div class='line' id='LC70'>			   <span class="p">(</span><span class="mi">0</span> <span class="nv">compilation-info-face</span><span class="p">))))</span></div><div class='line' id='LC71'><br/></div><div class='line' id='LC72'><span class="p">(</span><span class="nf">customize-set-variable</span> <span class="ss">&#39;comint-prompt-read-only</span> <span class="nv">t</span><span class="p">)</span></div><div class='line' id='LC73'><span class="p">(</span><span class="nf">customize-set-variable</span> <span class="ss">&#39;compilation-buffer-name-function</span> </div><div class='line' id='LC74'>			<span class="ss">&#39;sbt-build-buffer-name</span><span class="p">)</span></div><div class='line' id='LC75'><span class="p">(</span><span class="nf">customize-set-variable</span> <span class="ss">&#39;compilation-error-regexp-alist</span> </div><div class='line' id='LC76'>			<span class="p">(</span><span class="nb">list </span><span class="nv">scala-compile-error-regex</span><span class="p">))</span>  </div><div class='line' id='LC77'><span class="p">(</span><span class="nf">set</span> <span class="ss">&#39;compilation-auto-jump-to-first-error</span> <span class="nv">t</span><span class="p">)</span></div><div class='line' id='LC78'><br/></div><div class='line' id='LC79'><span class="p">(</span><span class="nf">ansi-color-for-comint-mode-on</span><span class="p">)</span></div><div class='line' id='LC80'><br/></div><div class='line' id='LC81'><span class="c1">;; Locate the project root directory from the source buffer location.</span></div><div class='line' id='LC82'><br/></div><div class='line' id='LC83'><span class="p">(</span><span class="nf">defun</span> <span class="nv">sbt-project-dir-p</span> <span class="p">(</span><span class="nf">path</span><span class="p">)</span></div><div class='line' id='LC84'>&nbsp;&nbsp;<span class="s">"Does a project/build.properties exists in the given path."</span></div><div class='line' id='LC85'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">file-exists-p</span> <span class="p">(</span><span class="nf">concat</span> <span class="nv">path</span> <span class="s">"/project/build.properties"</span><span class="p">)))</span></div><div class='line' id='LC86'><br/></div><div class='line' id='LC87'><span class="p">(</span><span class="nf">defun</span> <span class="nv">sbt-at-root</span> <span class="p">(</span><span class="nf">path</span><span class="p">)</span></div><div class='line' id='LC88'>&nbsp;&nbsp;<span class="s">"Determine if the given path is root."</span></div><div class='line' id='LC89'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">equal</span> <span class="nv">path</span> <span class="p">(</span><span class="nf">sbt-parent-path</span> <span class="nv">path</span><span class="p">)))</span></div><div class='line' id='LC90'><br/></div><div class='line' id='LC91'><span class="p">(</span><span class="nf">defun</span> <span class="nv">sbt-parent-path</span> <span class="p">(</span><span class="nf">path</span><span class="p">)</span></div><div class='line' id='LC92'>&nbsp;&nbsp;<span class="s">"The parent path for the given path."</span></div><div class='line' id='LC93'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">file-truename</span> <span class="p">(</span><span class="nf">concat</span> <span class="nv">path</span> <span class="s">"/.."</span><span class="p">)))</span></div><div class='line' id='LC94'><br/></div><div class='line' id='LC95'><span class="c1">;; Search up the directory tree until directory with a "project" subdir </span></div><div class='line' id='LC96'><span class="c1">;; is found with build.properties</span></div><div class='line' id='LC97'><span class="p">(</span><span class="nf">defun</span> <span class="nv">sbt-find-path-to-project</span> <span class="p">()</span></div><div class='line' id='LC98'>&nbsp;&nbsp;<span class="s">"Move up the directory tree for the current buffer until root or a directory with a project/build.properities is found."</span></div><div class='line' id='LC99'>&nbsp;&nbsp;<span class="p">(</span><span class="nf">interactive</span><span class="p">)</span></div><div class='line' id='LC100'>&nbsp;&nbsp;<span class="p">(</span><span class="k">let </span><span class="p">((</span><span class="nf">fn</span> <span class="p">(</span><span class="nf">buffer-file-name</span><span class="p">)))</span></div><div class='line' id='LC101'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="k">let </span><span class="p">((</span><span class="nf">path</span> <span class="p">(</span><span class="nf">file-name-directory</span> <span class="nv">fn</span><span class="p">)))</span></div><div class='line' id='LC102'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">(</span><span class="nf">while</span> <span class="p">(</span><span class="k">and </span><span class="p">(</span><span class="nb">not </span><span class="p">(</span><span class="nf">sbt-project-dir-p</span> <span class="nv">path</span><span class="p">))</span></div><div class='line' id='LC103'>		  <span class="p">(</span><span class="nb">not </span><span class="p">(</span><span class="nf">sbt-at-root</span> <span class="nv">path</span><span class="p">)))</span></div><div class='line' id='LC104'>	<span class="p">(</span><span class="nf">setf</span> <span class="nv">path</span> <span class="p">(</span><span class="nf">file-truename</span> <span class="p">(</span><span class="nf">sbt-parent-path</span> <span class="nv">path</span><span class="p">))))</span></div><div class='line' id='LC105'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">path</span><span class="p">)))</span></div><div class='line' id='LC106'><br/></div><div class='line' id='LC107'><br/></div></pre></div>
            
          </td>
        </tr>
      </table>
    
  </div>


      </div>
    </div>

  


    </div>
  
      
    </div>

    <div id="footer" class="clearfix">
      <div class="site">
        <div class="sponsor">
          <a href="http://www.rackspace.com" class="logo">
            <img alt="Dedicated Server" src="http://assets2.github.com/images/modules/footer/rackspace_logo.png?v2?d41521c484ad471778ea43ccfb07421d5ddb1942" />
          </a>
          Powered by the <a href="http://www.rackspace.com ">Dedicated
          Servers</a> and<br/> <a href="http://www.rackspacecloud.com">Cloud
          Computing</a> of Rackspace Hosting<span>&reg;</span>
        </div>

        <ul class="links">
          <li class="blog"><a href="http://github.com/blog">Blog</a></li>
          <li><a href="http://support.github.com">Support</a></li>
          <li><a href="http://github.com/training">Training</a></li>
          <li><a href="http://jobs.github.com">Job Board</a></li>
          <li><a href="http://shop.github.com">Shop</a></li>
          <li><a href="http://github.com/contact">Contact</a></li>
          <li><a href="http://develop.github.com">API</a></li>
          <li><a href="http://status.github.com">Status</a></li>
        </ul>
        <ul class="sosueme">
          <li class="main">&copy; 2010 <span id="_rrt" title="0.07790s from fe1.rs.github.com">GitHub</span> Inc. All rights reserved.</li>
          <li><a href="/site/terms">Terms of Service</a></li>
          <li><a href="/site/privacy">Privacy</a></li>
          <li><a href="http://github.com/security">Security</a></li>
        </ul>
      </div>
    </div><!-- /#footer -->

    
      
      
        <!-- current locale:  -->
        <div class="locales">
          <div class="site">

            <ul class="choices clearfix limited-locales">
              <li><span class="current">English</span></li>
              
                
                  <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=fr">Français</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=zh">中文</a></li>
                
              
              <li class="all"><a href="#" class="minibutton btn-forward js-all-locales"><span><span class="icon"></span>See all available languages</span></a></li>
            </ul>

            <div class="all-locales clearfix">
              <h3>Your current locale selection: <strong>English</strong>. Choose another?</h3>
              
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=en">English</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=af">Afrikaans</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=ca">Català</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=cs">Čeština</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=es">Español</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=fr">Français</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=hr">Hrvatski</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=id">Indonesia</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=it">Italiano</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=nl">Nederlands</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=no">Norsk</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=pl">Polski</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=sr">Српски</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=sv">Svenska</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=zh">中文</a></li>
                    
                  
                </ul>
              
            </div>

          </div>
          <div class="fade"></div>
        </div>
      
    

    <script>window._auth_token = "b01ddca66df53fc16bd74e9bc7533e3707e3d46b"</script>
    <div id="keyboard_shortcuts_pane" style="display:none">
  <h2>Keyboard Shortcuts</h2>

  <div class="columns threecols">
    <div class="column first">
      <h3>Site wide shortcuts</h3>
      <dl class="keyboard-mappings">
        <dt>s</dt>
        <dd>Focus site search</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>?</dt>
        <dd>Bring up this help dialog</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column middle">
      <h3>Commit list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>t</dt>
        <dd>Open tree</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>p</dt>
        <dd>Open parent</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>c <em>or</em> o <em>or</em> enter</dt>
        <dd>Open commit</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column last">
      <h3>Pull request list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>o <em>or</em> enter</dt>
        <dd>Open issue</dd>
      </dl>
    </div><!-- /.columns.last -->
  </div><!-- /.columns.equacols -->

  <div class="rule"></div>

  <h3>Issues</h3>

  <div class="columns threecols">
    <div class="column first">
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>x</dt>
        <dd>Toggle select target</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>o <em>or</em> enter</dt>
        <dd>Open issue</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column middle">
      <dl class="keyboard-mappings">
        <dt>I</dt>
        <dd>Mark selected as read</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>U</dt>
        <dd>Mark selected as unread</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>e</dt>
        <dd>Close selected</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>y</dt>
        <dd>Remove selected from view</dd>
      </dl>
    </div><!-- /.column.middle -->
    <div class="column last">
      <dl class="keyboard-mappings">
        <dt>c</dt>
        <dd>Create issue</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>l</dt>
        <dd>Create label</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>i</dt>
        <dd>Back to inbox</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>u</dt>
        <dd>Back to issues</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>/</dt>
        <dd>Focus issues search</dd>
      </dl>
    </div>
  </div>

  <div class="rule"></div>

  <h3>Network Graph</h3>
  <div class="columns equacols">
    <div class="column first">
      <dl class="keyboard-mappings">
        <dt>← <em>or</em> h</dt>
        <dd>Scroll left</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>→ <em>or</em> l</dt>
        <dd>Scroll right</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>↑ <em>or</em> k</dt>
        <dd>Scroll up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>↓ <em>or</em> j</dt>
        <dd>Scroll down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>t</dt>
        <dd>Toggle visibility of head labels</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column last">
      <dl class="keyboard-mappings">
        <dt>shift ← <em>or</em> shift h</dt>
        <dd>Scroll all the way left</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift → <em>or</em> shift l</dt>
        <dd>Scroll all the way right</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift ↑ <em>or</em> shift k</dt>
        <dd>Scroll all the way up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift ↓ <em>or</em> shift j</dt>
        <dd>Scroll all the way down</dd>
      </dl>
    </div><!-- /.column.last -->
  </div>

</div>
    

    <!--[if IE 8]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie8")
    </script>
    <![endif]-->

    <!--[if IE 7]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie7")
    </script>
    <![endif]-->

    <script type="text/javascript">
      _kmq.push(['trackClick', 'entice-signup-button', 'Entice banner clicked']);
      
    </script>
    
  </body>
</html>

