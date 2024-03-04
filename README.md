Bashbot is a script that allows you to interact with an AI-powered chatbot from the Linux terminal. The chatbot is a Cloudflare Worker that is set to use the [deepseek-coder-6.7b-instruct-awq LLM](https://developers.cloudflare.com/workers-ai/models/deepseek-coder-6.7b-instruct-awq/). The Cloudflare free plan is quite generous therefore I am sharing my chatbot with the world, hoping it will come in handy to someone.   

**Installation:**
```
git clone https://github.com/reacan/bashbot.git  
cd bashbot  
chmod +x install.sh  
./install.sh  
```
This will make the Bashbot script executable and copy it to your ~/.local/bin folder. As a result you will be able to call Bashbot by typing "bashbot" in your terminal. 

**To uninstall:**    
```
chmod+x uninstall.sh  
./uninstall.sh  
```
This will remove the script from your ~/.local/bin folder.

```
bashbot --help
```

```
Usage: bashbot [options]  
Options:  
  --help            Display this help message  
  -v, --version     Display the version of Bashbot  
  -m, --message     MESSAGE   Send a message to Bashbot  

Description:  
  Bashbot is a script that allows you to interact with an AI-powered chatbot.  

Interactive Mode:  
  To launch Bashbot in interactive mode, simply run 'bashbot' without any options.  
  In interactive mode, you can type messages directly into the terminal and receive responses from the chatbot.  

Examples:  
  bashbot                          # Launches Bashbot in interactive mode  
  bashbot -m "Hello, Bashbot!"     # Sends a message to Bashbot  
  bashbot --help                   # Displays this help message  
  bashbot -v                       # Displays the version of Bashbot  
```

