// Home page JavaScript file

document.addEventListener('DOMContentLoaded', () => {
  // 获取即将到来的活动
  fetchUpcomingEvents();
  
  // 获取活动类别
  fetchCategories();
  
  // 初始化搜索表单
  initSearchForm();
});

// Fetch upcoming events
async function fetchUpcomingEvents() {
  try {
    const response = await fetch(`${API_BASE_URL}/events`);
    if (!response.ok) {
      throw new Error('Failed to fetch events');
    }
    const events = await response.json();
    displayEvents(events.slice(0, 6)); // Show top 6 events
  } catch (error) {
    console.error('Failed to fetch events:', error);
    // If API call fails, show error message
    const eventsContainer = document.getElementById('upcoming-events');
    eventsContainer.innerHTML = '<p class="error-message">Unable to load events right now. Please try again later.</p>';
  }
}

// Display event list
function displayEvents(events) {
  const eventsContainer = document.getElementById('upcoming-events');
  
  if (events.length === 0) {
    eventsContainer.innerHTML = '<p>No upcoming events</p>';
    return;
  }
  
  eventsContainer.innerHTML = events.map(event => createEventCard(event)).join('');
}

// Fetch event categories
async function fetchCategories() {
  try {
    const response = await fetch(`${API_BASE_URL}/events/categories/all`);
    if (!response.ok) {
      throw new Error('Failed to fetch categories');
    }
    const categories = await response.json();
    displayCategories(categories);
  } catch (error) {
    console.error('Failed to fetch categories:', error);
    // If API call fails, show error message
    const categoriesContainer = document.getElementById('categories-list');
    if (categoriesContainer) {
      categoriesContainer.innerHTML = '<p class="error-message">Unable to load categories right now. Please try again later.</p>';
    }
  }
}

// Display categories
function displayCategories(categories) {
  const categoriesContainer = document.getElementById('categories-list');
  
  if (!categoriesContainer) {
    console.error('categories-list container not found');
    return;
  }
  
  if (categories.length === 0) {
    categoriesContainer.innerHTML = '<p>No categories available</p>';
    return;
  }
  
  categoriesContainer.innerHTML = categories.map(category => `
    <div class="category-item">
      <h3>${category.name}</h3>
      <p>${category.description || 'No description'}</p>
    </div>
  `).join('');
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
    
    // Navigate to search page
    window.location.href = `search.html?${searchParams.toString()}`;
  });
}