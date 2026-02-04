# AI Integration (Sidekick.nvim)

## Overview

This configuration includes `sidekick.nvim`, an AI assistant plugin designed for integration with development workflows. It provides access to AI models within your editor.

**File**: `lua/plugins/ai/sidekick.lua`

**Plugin**: sidekick.nvim (by folke, author of lazy.nvim)

## What is Sidekick?

Sidekick is a Neovim plugin that:
- Spawns AI sessions in isolated tmux windows
- Provides model access (Claude, GPT, etc.)
- Integrates with your development workflow
- Maintains conversation context across sessions
- Works with multiple AI backends

## Requirements

### System Dependencies

1. **tmux** - Required for spawning AI windows
   ```sh
   # macOS
   brew install tmux

   # Linux
   sudo apt-get install tmux
   ```

2. **AI Model Access** - Configure your AI provider:
   - Claude API key
   - OpenAI API key
   - Or other supported providers

### Environment Variables

Set your API key in shell:

```sh
export ANTHROPIC_API_KEY="your-api-key"
export OPENAI_API_KEY="your-api-key"  # If using OpenAI
```

Or in `~/.zshrc` or `~/.bashrc`:

```bash
# ~/.zshrc
export ANTHROPIC_API_KEY="sk-..."
```

## Configuration

### Current Setup

```lua
-- lua/plugins/ai/sidekick.lua
require('sidekick').setup({
  backend = 'tmux',  -- Use tmux for AI sessions
  model = 'claude',  -- Or 'gpt-4', 'gpt-3.5-turbo'
})
```

### Changing AI Model

Edit `lua/plugins/ai/sidekick.lua`:

```lua
require('sidekick').setup({
  model = 'gpt-4',  -- Switch to GPT-4
  -- or
  model = 'claude-opus',  -- Use Claude Opus
})
```

### Backend Options

- `tmux` - Recommended. Spawns in tmux windows
- `stdio` - Direct stdin/stdout
- `curl` - HTTP backend

## Using Sidekick

### Starting an AI Session

Once configured, you can invoke Sidekick (exact keybindings depend on configuration):

```vim
:Sidekick
```

This spawns a new tmux window with AI session.

### Interacting with AI

In the AI window:

1. Type your prompt or question
2. Submit with `<CR>` (Enter)
3. AI responds with context-aware answers
4. Continue conversation

### Using Code Context

Sidekick can read your current file/selection:

```vim
:Sidekick "Explain this function"
```

Sends the selected code to AI with your prompt.

### Multiple Sessions

Spawn multiple independent AI sessions in different tmux windows:

```vim
:Sidekick window1
:Sidekick window2
```

Each window maintains separate conversation context.

## Common AI Workflows

### 1. Code Explanation

1. Select code block in Neovim
2. Open Sidekick: `:Sidekick`
3. Ask "Explain this code"
4. AI explains the logic

### 2. Code Review

1. Select function in editor
2. `:Sidekick` with prompt "Review this for bugs"
3. Get AI feedback on code quality

### 3. Generate Test Cases

1. Select function
2. `:Sidekick "Generate test cases"`
3. AI suggests tests
4. Copy into test file

### 4. Documentation Writing

1. Select function/class
2. `:Sidekick "Write docstring"`
3. AI generates documentation
4. Refine and insert

### 5. Debugging Help

1. Copy error message/stack trace
2. `:Sidekick "Debug this error"`
3. AI provides debugging suggestions

### 6. Performance Optimization

1. Select algorithm/function
2. `:Sidekick "How to optimize this?"`
3. AI suggests improvements

## Integrating with Development

### Reading File Content

Sidekick can read files:

```vim
:Sidekick "Read /path/to/file and summarize"
```

### Using with Current Buffer

Send current file content:

```vim
:read !sidekick "Analyze this file"
```

(Depends on exact configuration)

### Copy AI Response

When AI responds, you can:
1. Copy response from tmux window
2. Paste into editor with `<leader>p` or mouse
3. Integrate into code

### Interactive Refinement

1. Ask initial question
2. AI responds
3. Follow up in same session
4. AI maintains context

## Advanced Usage

### Custom Prompts

Create aliases or shortcuts for common prompts:

```vim
" In ~/.config/nvim/init.lua or keymaps.lua:
vim.keymap.set('v', '<leader>ai', ':Sidekick "Explain this code"<CR>')
vim.keymap.set('v', '<leader>at', ':Sidekick "Write a test for this"<CR>')
vim.keymap.set('v', '<leader>ar', ':Sidekick "Review for bugs"<CR>')
```

Then in visual mode, select code and press `<leader>ai`.

### Shell Integration

Use sidekick from command line:

```bash
# In tmux/terminal:
sidekick "What is the difference between lists and tuples in Python?"

# Or pipe file:
cat myfile.lua | sidekick "Optimize this code"
```

## Conversation Context

### Maintaining Context

- Single session maintains conversation history
- AI remembers previous messages
- Useful for iterative refinement

### Starting Fresh

Open new Sidekick window for fresh context:

```vim
:Sidekick new
```

Each session is independent.

### Exiting Session

In tmux window:
```
exit
```

Or kill the window with tmux commands.

## Troubleshooting

### "Backend not available"

1. Ensure tmux is installed: `which tmux`
2. Check environment: `echo $TMUX`
3. May need to restart shell: `source ~/.zshrc`

### "API key not found"

1. Verify env var set: `echo $ANTHROPIC_API_KEY`
2. Check in Neovim: `:echo $ANTHROPIC_API_KEY`
3. May need `:source` to reload environment

### "Model not found"

1. Check model name matches API provider
2. Verify API account has access to model
3. Test in terminal: `curl -H "Authorization: Bearer $APIKEY" ...`

### Sidekick command not working

1. Verify sidekick.nvim is loaded: `:Lazy`
2. Check configuration in `lua/plugins/ai/sidekick.lua`
3. Manual test: `:!sidekick "test"`

### tmux window doesn't appear

1. Check tmux running: `tmux list-sessions`
2. Verify tmux installed: `tmux -V`
3. Try creating window manually: `tmux new-window`

## Tips & Best Practices

### 1. Context-Aware Prompts

Include context in your prompt:
- **Good**: "Review this login function for security vulnerabilities"
- **Bad**: "Review this"

### 2. Iterate

Ask follow-up questions:
1. "Explain async/await"
2. "How is that different from promises?"
3. "Show an example with error handling"

AI remembers previous messages in session.

### 3. Code Blocks

Ask AI to provide code in clear format:
- "Provide the code block as plain text I can copy"
- "Use markdown syntax highlighting"

### 4. Multiple Perspectives

Open separate sessions for different purposes:
- Window 1: Code review
- Window 2: Documentation
- Window 3: Debugging

### 5. Combine with Editor

- Use `<leader>y` to copy code to clipboard
- Paste into Sidekick: `<leader>p`
- Get AI response
- Copy back to editor

### 6. Save Responses

In tmux, use tmux's capture-pane:

```bash
tmux capture-pane -p -t <window> > ai_response.txt
```

Saves AI response for later reference.

## Privacy & Security

### API Keys

- Never commit API keys to git
- Use environment variables
- Use `.env` file (not in git)
- Regenerate keys if exposed

### Code Sent to AI

- Code is sent to AI service
- Consider sensitive data implications
- Use sparingly with proprietary code
- Check provider's privacy policy

### Local Models

For privacy, consider local models:
- llama.cpp (local Llama)
- Ollama (local models)
- vLLM (self-hosted)

Configure sidekick with local endpoint instead.

## Performance

### Response Time

- Depends on model and API speed
- Claude usually responds in 2-10 seconds
- May be slower during peak usage

### Token Usage

- Monitor API usage
- Each conversation costs tokens
- Longer prompts = more tokens

### Optimizing Costs

- Use cheaper models for simple tasks
- Batch related questions in one session
- Close unused sessions

## Advanced: Custom Backend

Create custom backend for different AI service:

In `lua/plugins/ai/sidekick.lua`:

```lua
require('sidekick').setup({
  backend = 'custom',
  backend_cmd = 'my-ai-client',  -- Your custom command
})
```

Then create `my-ai-client` script that handles the AI interaction.

## Comparison: Sidekick vs Other AI Tools

### Sidekick (This Config)
- **Pros**: Integrated in tmux, maintains context, flexible
- **Cons**: Requires setup, depends on tmux
- **Best for**: Developers who use tmux

### Copilot
- **Pros**: Code completion, very integrated
- **Cons**: Subscription required, inline only
- **Best for**: Fast code generation

### ChatGPT (Web UI)
- **Pros**: Easy to use, free tier available
- **Cons**: Context switching, slow workflow
- **Best for**: One-off questions

### Local LLMs
- **Pros**: Privacy, offline, no API costs
- **Cons**: Slower, require local setup, less capable
- **Best for**: Privacy-focused developers

## Resources

- [Sidekick.nvim](https://github.com/folke/sidekick.nvim) (if available publicly)
- [Anthropic API Documentation](https://docs.anthropic.com/)
- [OpenAI API Documentation](https://platform.openai.com/docs/)
- [tmux Manual](https://man.openbsd.org/tmux)

## Next Steps

1. Set up API key (see Requirements section)
2. Test sidekick: `:Sidekick "Say hello"`
3. Create custom prompts for your workflow
4. Integrate into development process
5. Share useful prompts with team

## Example Workflow Session

```
1. Working on function in Neovim
2. Select function text: vaf
3. :Sidekick "Review for bugs and suggest optimizations"
4. AI responds with feedback
5. Ask follow-up: "How would you implement the optimization?"
6. AI provides code example
7. Copy example from tmux to Neovim
8. Apply changes and test
```

This cycle combines AI assistance with your editor seamlessly.
