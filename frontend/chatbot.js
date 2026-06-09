(function () {
  const BACKEND_URL = 'http://localhost:5000';
  let chatHistory = [];

  document.body.insertAdjacentHTML('beforeend', `
    <div id="chatbot-bubble" onclick="toggleChat()" title="Chat with AI Assistant">&#128172; Chat with AI</div>
    <div id="chatbot-window">
      <div id="chatbot-header">
        <span>AI Assistant</span>
        <button onclick="toggleChat()">Close</button>
      </div>
      <div id="chatbot-messages">
        <div class="bot-msg">Hello! I am the AI-Solutions assistant. How can I help you today?</div>
      </div>
      <div id="chatbot-input-area">
        <input type="text" id="chatbot-input" placeholder="Type a message..." onkeydown="if(event.key==='Enter') sendChat()"/>
        <button onclick="sendChat()">Send</button>
      </div>
    </div>
    <style>
      #chatbot-bubble { position:fixed; bottom:18px; left:18px; background:#00d4ff; color:#1a1a2e; min-width:122px; height:42px; padding:0 14px; border-radius:8px; display:flex; align-items:center; justify-content:center; gap:6px; font-size:0.86rem; font-weight:bold; cursor:pointer; box-shadow:0 4px 15px rgba(0,212,255,0.35); z-index:999; transition:transform 0.2s; }
      #chatbot-bubble:hover { transform:scale(1.06); }
      #chatbot-window { position:fixed; bottom:72px; left:18px; width:340px; height:460px; background:var(--paper, white); border-radius:12px; box-shadow:0 8px 30px rgba(0,0,0,0.2); display:none; flex-direction:column; z-index:998; overflow:hidden; }
      #chatbot-window.open { display:flex; }
      #chatbot-header { background:#1a1a2e; color:white; padding:14px 16px; display:flex; justify-content:space-between; align-items:center; font-weight:bold; }
      #chatbot-header button { background:none; border:none; color:white; font-size:0.85rem; cursor:pointer; font-weight:bold; }
      #chatbot-messages { flex:1; overflow-y:auto; padding:15px; display:flex; flex-direction:column; gap:10px; background:var(--soft, #f9f9f9); }
      .bot-msg { background:#e8f4ff; color:#1a1a2e; padding:10px 14px; border-radius:12px 12px 12px 0; max-width:85%; font-size:0.88rem; line-height:1.5; align-self:flex-start; }
      .user-msg { background:#1a1a2e; color:white; padding:10px 14px; border-radius:12px 12px 0 12px; max-width:85%; font-size:0.88rem; line-height:1.5; align-self:flex-end; }
      .typing-msg { background:#e8f4ff; color:#475569; padding:10px 14px; border-radius:12px 12px 12px 0; font-size:0.88rem; align-self:flex-start; font-style:italic; }
      #chatbot-input-area { display:flex; border-top:1px solid var(--line, #eee); padding:10px; gap:8px; background:var(--paper, white); }
      #chatbot-input { flex:1; padding:8px 12px; border:1px solid var(--line, #ccc); border-radius:20px; font-size:0.88rem; outline:none; background:var(--input-bg, white); color:var(--ink, #111827); }
      #chatbot-input:focus { border-color:#00d4ff; }
      #chatbot-input-area button { background:#00d4ff; color:#1a1a2e; border:none; padding:8px 16px; border-radius:20px; font-weight:bold; cursor:pointer; font-size:0.88rem; }
      #chatbot-input-area button:hover { background:#00b8d9; }
      @media (max-width: 560px) {
        #chatbot-bubble { left:12px; bottom:16px; min-width:112px; height:40px; padding:0 10px; font-size:0.8rem; }
        #chatbot-window { left:12px; right:12px; bottom:68px; width:auto; height:min(430px, 62vh); }
        #chatbot-input-area { flex-wrap:wrap; }
        #chatbot-input-area button { width:100%; }
      }
    </style>
  `);

  window.toggleChat = function() {
    const win = document.getElementById('chatbot-window');
    win.classList.toggle('open');
    if (win.classList.contains('open')) document.getElementById('chatbot-input').focus();
  };

  window.sendChat = async function() {
    const input = document.getElementById('chatbot-input');
    const messages = document.getElementById('chatbot-messages');
    const text = input.value.trim();
    if (!text) return;

    chatHistory.push({ role: 'user', text });

    messages.insertAdjacentHTML('beforeend', `<div class="user-msg">${text}</div>`);
    input.value = '';
    messages.scrollTop = messages.scrollHeight;

    const typingId = 'typing-' + Date.now();
    messages.insertAdjacentHTML('beforeend', `<div class="typing-msg" id="${typingId}">AI is typing...</div>`);
    messages.scrollTop = messages.scrollHeight;

    try {
      const res = await fetch(`${BACKEND_URL}/api/chat`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ message: text, history: chatHistory })
      });
      const data = await res.json();
      document.getElementById(typingId)?.remove();

      chatHistory.push({ role: 'ai', text: data.reply });
      if (chatHistory.length > 12) chatHistory = chatHistory.slice(-12);

      messages.insertAdjacentHTML('beforeend', `<div class="bot-msg">${data.reply}</div>`);
    } catch {
      document.getElementById(typingId)?.remove();
      messages.insertAdjacentHTML('beforeend', `<div class="bot-msg">Sorry, I am unable to connect right now. Please try again later.</div>`);
    }
    messages.scrollTop = messages.scrollHeight;
  };
})();
