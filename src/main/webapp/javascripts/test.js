function setAreaStyle(area) { for(var i = 1; i < arguments.length; i += 2) { area.style[arguments[i]] = arguments[i+1]; } }
function closeObj(obj) { if(obj) { setAreaStyle(obj, 'visibility', 'hidden', 'display', 'none'); setTimeout(function(){obj.parentNode.removeChild(obj);},1); } }
function embedSwf(agSrc, agId, agWidth, agHeight, agWmode, agArea, agVars) {
	var html = [];
	html[html.length] = '<object width="' + agWidth + '" height="' + agHeight + '" id="' + agId + '" name="' + agId + '" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,124,0">';
	html[html.length] = '<param name="movie" value="' + agSrc + '" />';
	html[html.length] = '<param name="wmode" value="' + agWmode + '" />';
	html[html.length] = '<param name="quality" value="high" />';
	html[html.length] = '<param name="allowScriptAccess" value="always" />';
	html[html.length] = '<param name="FlashVars" value="' + agVars + '" />';
	html[html.length] = '<embed width="' + agWidth + '" height="' + agHeight + '" name="' + agId + '" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" ';
	html[html.length] = ' src="' + agSrc + '" wmode="' + agWmode + '" quality="high" allowScriptAccess="always" FlashVars="' + agVars + '" />';
	html[html.length] = '</object>';
	if (agArea) { agArea.innerHTML = html.join(''); }
}

function MiniSite(skin, wrapId) {
	if ( window.MiniSiteObj ) { // Singleton
		return window.MiniSiteObj;
	}
	window.MiniSiteObj = this;
	
	this.isMinisiteShow = false;

	var data = {
		 basicFile : 'benner_978x89.swf',
		 basicClickUrl : 'http://www.tistory.com/?basicClick',
		
		 basicSkinFile : 'skin_game_978x89.swf',
		 basicSkinFileW : 978,
		 basicSkinFileH : 89,

		 objeSkinFile : 'skin_game_288x107.swf',
		 objeSkinFileW : 288,
		 objeSkinFileH : 107,
		
		 objeFile : 'obje_288x107.png',
		 objeClickUrl : '',

		 minisiteFile : 'minisite_978x415.swf',
		 minisiteClickUrl : 'http://www.tistory.com/?minisiteClickUrl',
		 minisiteExpandUrl : '',
		
		 minisiteSkinFile : 'skin_game_978x415.swf',
		 minisiteSkinFileW : 978,
		 minisiteSkinFileH : 415
	};
	
	for ( var key in skin ) {
		data[key] = skin[key];
	}
			
	var gv = {};
	gv.Agent = navigator.userAgent.toLowerCase();
	gv.IE = (window.attachEvent && (gv.Agent.toLowerCase().indexOf('msie') !== -1)) ? true : false;
	gv.CHROME = (gv.Agent.toLowerCase().indexOf('chrome') !== -1) ? true : false;
	gv.SAFARI = (gv.Agent.toLowerCase().indexOf('safari') !== -1) ? true : false;
	gv.RandStr = Math.random().toString();
	gv = {
		OpenMethod : 'get',
		UseEffect : ((gv.IE && Function.call) || gv.CHROME || gv.SAFARI) ? 'Y' : 'N',
		ParentArea : wrapId || 'bannerDN_wrap',
		BannerArea : 'gameAdBar',
		EffectArea : 'gameAdMini',
		ObjeArea : 'gameAdObje',
		ConnectName : gv.RandStr.substring(2, gv.RandStr.length)
	};
	
	( function () {
		var bannerArea = document.getElementById(gv.BannerArea);
		if (gv.UseEffect == 'Y') {
			setAreaStyle(bannerArea, 'width', data.basicSkinFileW+'px', 'height', data.basicSkinFileH + 'px', 'position', 'absolute', 'top', '0', 'left', '0');
		}
		var fVars = []
		fVars[fVars.length] = 'openMethod=' + gv.OpenMethod + '&windowName=' + window.name + '&useEffect=' + gv.UseEffect;
		fVars[fVars.length] = '&basicFile=' + escape(data.basicFile) + '&basicClickUrl=' + escape(data.basicClickUrl);
		

		var objeArea = document.getElementById(gv.ObjeArea);
		setAreaStyle(objeArea, 'width', objeSkinFileW +'px', 'height', objeSkinFileH + 'px', 'position', 'absolute', 'top', '-18px', 'right', '0px','zIndex','9');

		var fObjeVars = []
		fObjeVars[fObjeVars.length] = 'objeFile='+escape(data.objeFile)+ '&objeClickUrl=' + escape(data.objeClickUrl);
		fObjeVars[fObjeVars.length] = '&connectName='+gv.ConnectName;
		
		embedSwf(data.basicSkinFile, '', data.basicSkinFileW, data.basicSkinFileH, 'transparent', bannerArea, fVars.join(''));
		embedSwf(data.objeSkinFile, '', data.objeSkinFileW, data.objeSkinFileH, 'transparent', objeArea, fObjeVars.join(''));
		this.isMinisiteShow = false;
		
		window.closeMinisite = function () {
			return function() { closeObj(document.getElementById(gv.EffectArea));this.isMinisiteShow = false; };
		};
		
		window.showMinisite = function() {
			return function() {
				var parentArea = document.getElementById(gv.ParentArea);
				if (parentArea && this.isMinisiteShow == false) {
					window.isMinisiteShow = true;
					var effectArea = parent.document.getElementById(gv.EffectArea);
					if ( effectArea ) {
						closeObj(effectArea);
					}
					effectArea = parent.document.createElement('div');
					effectArea.id = gv.EffectArea;
					effectArea.style.cssText="position:absolute";
					setAreaStyle(effectArea, 'width', data.minisiteSkinFileW +'px', 'height', data.minisiteSkinFileH + 'px', 'position', 'absolute', 'top', '-'+(data.minisiteSkinFileH-data.basicSkinFileH)+'px', 'left', '0px', 'zIndex','10');
					parentArea.appendChild(effectArea);

					var fVars = [];
					fVars[fVars.length] = 'openMethod=' + gv.OpenMethod + '&windowName=' + window.name;
					fVars[fVars.length] = '&minisiteFile=' + escape(data.minisiteFile) + '&minisiteClickUrl=' + escape(data.minisiteClickUrl)+'&minisiteExpandUrl=' + escape(data.minisiteExpandUrl);
					fVars[fVars.length] = '&connectName='+gv.ConnectName;
					embedSwf(data.minisiteSkinFile, '', data.minisiteSkinFileW, data.minisiteSkinFileH, 'transparent', effectArea, fVars.join(''));
				}
			}
		}
	})();
}