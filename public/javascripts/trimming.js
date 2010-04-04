window.onload = function()
{
	if(document.getElementById)
	{
		var linkContainer = document.getElementById('linkContainer');
		var toggle = linkContainer.appendChild(document.createElement('a'));
		toggle.href = '#';
		toggle.appendChild(document.createTextNode('Remove optional fields?'));
		toggle.onclick = function()
		{
			var linkText = this.firstChild.nodeValue;
			this.firstChild.nodeValue = (linkText == 'Remove optional fields?') ? 'Display optional fields?' : 'Remove optional fields?';
			
			var tmp = document.getElementsByTagName('p');
			for (var i=0;i<tmp.length;i++)
			{
				if(tmp[i].className == 'optional')
				{
					tmp[i].style.display = (tmp[i].style.display == 'none') ? 'block' : 'none';
				}
			}
			return false;
		}
	}
}