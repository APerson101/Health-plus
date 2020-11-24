import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
admin.initializeApp()
// let is_addComment_initialized = false

exports.addComment = functions.https.onCall(async(data) => {

// })
    // const admin = await import('firebase-admin')
    // if (!is_addComment_initialized) {
    //     admin.initializeApp()
    //     is_addComment_initialized = true;
    // }

    //save comment
    try {
        await saveComment(data)
        //update notifications
        await updateNotifications( data)
        //update comment count
        await updateCommentCount( data.PostID)
        return 'Successful'
    }
    catch (err) {
        console.log('there was an error while attempting to write some stuff')
        return 'Failure'
    }
})

async function saveComment( data:any) {
    const comment_ = data.comment;
    var timeStamp= new admin.firestore.Timestamp(data.seconds,data.nano)
    comment_.date_posted=timeStamp
    
    try{await admin.firestore().collection(`Posts/${data.PostID}/comments`).add(comment_)
}catch (err){console.log(err)}
    
}

async function updateCommentCount(postID: String) {
    try{
    await admin.firestore().doc(`Posts/${postID}`).
        update({'comments_count': admin.firestore.FieldValue.increment(1)})
    }catch(err){console.log(err)}

}

async function updateNotifications( data:any) {
    var timeStamp= new admin.firestore.Timestamp(data.seconds,data.nano)
    data.notification.date_created=timeStamp
    try{
        //notification count
    // await admin.firestore().collection(`Notifications/${data.username}/notifications`).add(data.notification)
     await admin.firestore().collection(`Notifications`).doc(data.username).set({})
     await admin.firestore().collection(`Notifications`).doc(data.username).collection('notifications').add(data.notification)
    }
catch{
  console.log('error or something, i do not know what to expect')  // await admin.firestore().collection(`Notifications/${data.username}/notifications`).add(data.notification)
}

}

exports.toggleLikeComment=functions.https.onCall(async(data)=>
{
    try {
        var ranShardID=Math.random()*Math.floor(5)
            var ref=admin.firestore().collection(`Posts/${data.postID}/Likes/{likeID}/shards`).doc(ranShardID.toString())
        if(!data.likeStatus){      
            await ref.set({count:admin.firestore.FieldValue.increment(1)}, {merge:true}) 
            await admin.firestore().collection(`Likes/${data.userID}/comments`).add(data.commentID.toString())
                  
        }
        else
        {
            await ref.set({count:admin.firestore.FieldValue.increment(-1)}, {merge:true})   
            await admin.firestore().doc(`Likes/${data.userID}/comments/${data.commentID}`).delete()
        }
    } catch (error) {
        console.error(error)
    }
})

exports.toggleLikePost=functions.https.onCall(async(data)=>
{
    try {
        
    } catch (error) {
        console.error(error)
    }
})