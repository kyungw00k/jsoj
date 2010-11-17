package net.jsoj.facade;

import java.io.Serializable;

//import com.google.appengine.api.channel.ChannelMessage;
//import com.google.appengine.api.channel.ChannelService;
//import com.google.appengine.api.channel.ChannelServiceFactory;

public class Channel implements Serializable {
	private static final long serialVersionUID = 8069506158368819995L;
	
	public void saySomething(String say){
//		ChannelService channel = ChannelServiceFactory.getChannelService();
//		ChannelMessage msg = new ChannelMessage("introPage",say);
//		channel.sendMessage(msg);
	}
}
