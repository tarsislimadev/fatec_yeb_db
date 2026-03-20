# python -m pip install pyppeteer

# npx @puppeteer/browsers install chrome@stable

import asyncio, os
from pyppeteer import launch, connect

async def main():
  browser = None
  try:
    # Find chrome executable installed by @puppeteer/browsers
    import glob
    chrome_candidates = [
      f for f in glob.glob("./chrome/**/chrome", recursive=True) 
      if os.access(f, os.X_OK) and os.path.isfile(f)
    ]
    exec_path = chrome_candidates[0] if chrome_candidates else None
    
    if exec_path:
      print(f"Using Chrome binary at: {exec_path}")
    else:
      print("No pre-installed Chrome binary found. Pyppeteer will try to manage its own.")

    # Launching with args for Docker compatibility
    browser = await launch(
      executablePath=exec_path,
      args=['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage'],
      headless=True
    )
    
    page = await browser.newPage()
    await page.setViewport({'width': 1280, 'height': 800})
    
    # Econodata search URL formulation
    search_url = f"https://www.econodata.com.br/consulta-empresa?filtro={query}"
    print(f"Navigating to {search_url}")
    
    await page.goto(search_url, {'waitUntil': 'networkidle2', 'timeout': 60000})
    
    # Extract content and find CNPJs using regex
    content = await page.content()
    found_cnpjs = re.findall(r'\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}', content)
    
    # Clean and unique list
    unique_cnpjs = list(set(found_cnpjs))
    print(f"Discovery phase: extracted {len(unique_cnpjs)} CNPJs from Econodata.")
    
    print(f'unique_cnpjs: {unique_cnpjs}')

  except Exception as e:
    print(f"Econodata extraction failed: {e}")
    return []
  finally:
    if browser:
      await browser.close()

asyncio.get_event_loop().run_until_complete(main())
