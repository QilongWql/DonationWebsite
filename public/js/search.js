// Search page JavaScript file

document.addEventListener('DOMContentLoaded', () => {
  // 获取活动类别
  fetchCategories();
  
  // 初始化搜索表单
  initSearchForm();
  
  // 检查URL参数并执行搜索
  checkUrlParamsAndSearch();
});

// Fetch event categories
async function fetchCategories() {
  try {
    const response = await fetch(`${API_BASE_URL}/events/categories/all`);
    if (!response.ok) {
      throw new Error('Failed to fetch categories');
    }
    
    const categories = await response.json();
    
    // 为类别选择添加选项
    const categorySelect = document.getElementById('category');
    categories.forEach(category => {
      const option = document.createElement('option');
      option.value = category.category_id;
      option.textContent = category.name;
      categorySelect.appendChild(option);
    });
  } catch (error) {
    console.error('Failed to fetch categories:', error);
  }
}

// Initialize search form
function initSearchForm() {
  const searchForm = document.getElementById('search-form');
  
  searchForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    const formData = new FormData(searchForm);
    const searchParams = new URLSearchParams();
    
    for (const [key, value] of formData.entries()) {
      if (value) {
        searchParams.append(key, value);
      }
    }
    
    // Update URL and execute search
    window.history.pushState({}, '', `?${searchParams.toString()}`);
    searchEvents(Object.fromEntries(searchParams));
  });
}

// Check URL params and execute search
function checkUrlParamsAndSearch() {
  const urlParams = new URLSearchParams(window.location.search);
  const filters = {};
  
  // Get search params from URL
  for (const [key, value] of urlParams.entries()) {
    filters[key] = value;
    
    // 设置表单值
    const input = document.querySelector(`[name="${key}"]`);
    if (input) {
      input.value = value;
    }
  }
  
  // If there are search params, execute search
  if (Object.keys(filters).length > 0) {
    searchEvents(filters);
  } else {
    // Otherwise fetch all events
    fetchAllEvents();
  }
}

// Fetch all events
async function fetchAllEvents() {
  const resultsContainer = document.getElementById('search-results');
  
  try {
    const response = await fetch(`${API_BASE_URL}/events`);
    if (!response.ok) {
      throw new Error('Failed to fetch events');
    }
    
    const events = await response.json();
    
    if (events.length === 0) {
      resultsContainer.innerHTML = '<p class="no-results">No events</p>';
      return;
    }
    
    resultsContainer.innerHTML = events.map(event => createEventCard(event)).join('');
  } catch (error) {
    console.error('Failed to fetch events:', error);
    showError(resultsContainer, 'Failed to fetch events. Please try again later.');
  }
}

// Search events
async function searchEvents(filters) {
  const resultsContainer = document.getElementById('search-results');
  resultsContainer.innerHTML = '<div class="loading">Searching...</div>';
  
  try {
    // 构建查询参数
    const searchParams = new URLSearchParams();
    for (const [key, value] of Object.entries(filters)) {
      if (value) {
        searchParams.append(key, value);
      }
    }
    
    const response = await fetch(`${API_BASE_URL}/events/search/filter?${searchParams.toString()}`);
    if (!response.ok) {
      throw new Error('Failed to search events');
    }
    
    const events = await response.json();
    
    if (events.length === 0) {
      resultsContainer.innerHTML = '<p class="no-results">No matching events found</p>';
      return;
    }
    
    resultsContainer.innerHTML = events.map(event => createEventCard(event)).join('');
  } catch (error) {
    console.error('Failed to search events:', error);
    showError(resultsContainer, 'Failed to search events. Please try again later.');
  }
}