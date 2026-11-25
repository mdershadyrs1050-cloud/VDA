const cfg=window.SKYNESS_CONFIG||{};
const configured=cfg.supabaseUrl?.startsWith('https://') && !cfg.supabaseUrl.includes('PASTE_') && cfg.supabaseAnonKey && !cfg.supabaseAnonKey.includes('PASTE_');
const db=configured && window.supabase ? window.supabase.createClient(cfg.supabaseUrl,cfg.supabaseAnonKey) : null;
function errorText(e){return e?.message||'Unexpected error';}
function showFormMessage(form,msg,ok){let el=form.querySelector('.form-feedback');if(!el){el=document.createElement('p');el.className='form-feedback';el.setAttribute('role','status');form.append(el);}el.style.cssText='margin-top:15px;font-size:13px;line-height:1.6;color:'+(ok?'#8ce1c4':'#ffc3b9');el.textContent=msg;}
