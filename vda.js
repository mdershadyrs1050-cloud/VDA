const form=document.getElementById('vdaForm');
form?.addEventListener('submit',async e=>{e.preventDefault();if(!db){showFormMessage(form,'Service temporarily unavailable. Please email skynesspvt@gmail.com.',false);return;}
 const f=new FormData(form);const item={intent:f.get('intent'),name:String(f.get('name')||'').trim(),phone:String(f.get('phone')||'').trim(),email:String(f.get('email')||'').trim(),location:String(f.get('location')||'').trim(),message:String(f.get('message')||'').trim()};
 const btn=form.querySelector('[type=submit]');btn.disabled=true;btn.textContent='Submitting…';
 try{const {error}=await db.from('enquiries').insert(item);if(error)throw error;showFormMessage(form,'Thank you. Your VDA enquiry has been received. Our team will review it.',true);form.reset();}
 catch(err){console.error('VDA submit error',err);showFormMessage(form,'Unable to submit right now. Please try again or email skynesspvt@gmail.com.',false);}
 finally{btn.disabled=false;btn.textContent='Submit VDA Enquiry ↗';}
});
