trigger onFeedUpdate on FeedItem (after insert, after update) {

  //  chatterUpdate();

    if(Trigger.IsInsert) {
        system.debug('insert feedItem');
    }

    if(Trigger.IsUpdate) {
        system.debug('update feedItem');
    }

/*public void chatterUpdate(){


FeedItem post = new FeedItem();

      
            post.CreatedById ='00590000003L41AAAS';

            post.Id='0D59000001MnxNuCAJ';
            post.Body='Ritesh Update';

            update post;

}*/

}