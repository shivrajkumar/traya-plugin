---
name: api-integrator
description: Comprehensive API integration workflow for Next.js applications. Use this skill when connecting backend APIs to UI components. The skill implements a systematic integration process using Postman MCP for API testing, Chrome DevTools MCP for network monitoring and debugging, Context7 MCP for best practices, and Serena MCP for codebase analysis. Covers API discovery, testing, frontend integration, validation, and security audit.
---

# API Integrator

## Overview

This skill provides a complete API integration workflow that connects backend APIs with your UI components through a systematic approach: API discovery → Postman testing → Frontend integration → Integration testing → Security audit. The workflow ensures APIs are validated before integration and thoroughly tested after implementation.

## Core Workflow

Follow this sequential workflow for all API integration tasks:

### Phase 1: API Discovery & Planning

**1. Understand API Requirements**

Gather context about what APIs need to be integrated:
- Review component/page requirements
- Identify all required endpoints
- Understand data flow and dependencies
- Note authentication requirements
- Identify success criteria

**2. Analyze Existing Patterns**

Use Serena MCP to understand current API patterns:
```
mcp__serena__search_for_pattern - Find existing API integration patterns
mcp__serena__find_symbol - Locate API client utilities
mcp__serena__get_symbols_overview - Review API-related files
```

Look for:
- Existing API client structure
- Authentication patterns
- Error handling conventions
- Data fetching strategies (SSR/CSR/SSG)
- Context usage for API data
- Loading state patterns

**3. Research Best Practices**

Use Context7 MCP to fetch current documentation:
```
mcp__context7__resolve-library-id - Resolve Next.js/React
mcp__context7__get-library-docs - Get latest patterns for:
  - Next.js 14 data fetching (SSR, CSR, SSG, ISR)
  - API client patterns (Axios, fetch)
  - React Query or SWR for client-side data
  - Authentication patterns (JWT, OAuth)
  - Error handling best practices
```

**4. Determine Integration Strategy**

Choose appropriate rendering and data fetching approach:

**SSR (Server-Side Rendering)** - DEFAULT for most pages
- Use when: Dynamic content, SEO important, personalized data
- Implementation: Server Components with async/await
- Example: User dashboards, product pages, form pages

**CSR (Client-Side Rendering)** - For interactive features
- Use when: Real-time updates, client-only features, highly interactive
- Implementation: 'use client' + useEffect or React Query/SWR
- Example: Live chat, notifications, interactive tools

**SSG (Static Site Generation)** - For static content
- Use when: Content rarely changes, no personalization
- Implementation: generateStaticParams() for dynamic routes
- Example: Marketing pages, blog posts, documentation

**ISR (Incremental Static Regeneration)** - For semi-static content
- Use when: Content updates periodically but not on every request
- Implementation: revalidate option in fetch or page config
- Example: Product catalogs, news feeds

**Planning Checklist:**
- [ ] All required endpoints identified
- [ ] Authentication method understood (JWT, OAuth, API keys)
- [ ] Data fetching strategy defined (SSR/CSR/SSG/ISR)
- [ ] Error scenarios planned
- [ ] Loading states designed
- [ ] Rate limits documented
- [ ] Caching strategy defined
- [ ] Existing patterns reviewed with Serena

### Phase 2: API Testing with Postman

**5. Comprehensive Endpoint Testing**

Before integrating, validate all APIs thoroughly using Postman MCP:

**Create Test Collections:**

For each endpoint, test:
- ✅ Successful requests (200, 201, 204)
- ✅ Authentication (valid/invalid tokens)
- ✅ Validation errors (400)
- ✅ Authorization errors (401, 403)
- ✅ Not found errors (404)
- ✅ Server errors (500)
- ✅ Response schema validation
- ✅ Performance (target: <200ms)

**Authentication Testing Structure:**
```
Collection: Authentication
├── POST /auth/login
│   ├── Valid credentials → 200
│   ├── Invalid credentials → 401
│   ├── Missing fields → 400
│   └── Performance check (<200ms)
├── POST /auth/refresh
│   ├── Valid token → 200
│   ├── Expired token → 401
│   └── Invalid token → 401
└── POST /auth/logout
    ├── Valid session → 200
    └── No session → 401
```

**CRUD Testing Template:**
```
Collection: {Resource}
├── GET /api/{resource}
│   ├── Success with data → 200
│   ├── Success empty → 200
│   ├── Unauthorized → 401
│   ├── Pagination works
│   ├── Filtering works
│   └── Performance check
├── GET /api/{resource}/{id}
│   ├── Valid ID → 200
│   ├── Invalid ID → 404
│   └── Unauthorized → 401
├── POST /api/{resource}
│   ├── Valid data → 201
│   ├── Invalid data → 400
│   ├── Missing required → 400
│   ├── Duplicate → 409
│   └── Unauthorized → 401
├── PUT /api/{resource}/{id}
│   ├── Valid update → 200
│   ├── Invalid data → 400
│   ├── Not found → 404
│   └── Unauthorized → 401
└── DELETE /api/{resource}/{id}
    ├── Valid delete → 204
    ├── Not found → 404
    └── Unauthorized → 401
```

**Testing Validation Checklist:**
- [ ] All endpoints return expected status codes
- [ ] Response schemas match documentation
- [ ] Authentication works correctly
- [ ] Error messages are clear and actionable
- [ ] Performance targets met (<200ms average)
- [ ] Rate limiting works as expected
- [ ] Pagination works correctly
- [ ] Filtering/sorting works correctly
- [ ] All edge cases covered

**6. Generate Test Report**

Document findings from Postman testing:
```markdown
# API Test Report

## Summary
- Total Endpoints: {COUNT}
- Total Tests: {COUNT}
- Passed: {COUNT} ({PERCENTAGE}%)
- Failed: {COUNT} ({PERCENTAGE}%)
- Average Response Time: {TIME}ms

## Authentication
- ✅ Login flow works
- ✅ Token refresh works
- ✅ Invalid credentials rejected
- ✅ Token expiration handled

## Endpoints Tested
{LIST_EACH_ENDPOINT_WITH_STATUS}

## Issues Found
{LIST_ANY_ISSUES}

## Ready for Integration
{YES/NO - explain blockers if any}
```

### Phase 3: Frontend Integration

**7. Set Up API Client**

Create centralized API client with interceptors:

**API Client Structure:**
```
src/lib/
├── api-client.ts          # Main API client with interceptors
├── api/
│   ├── endpoints/
│   │   ├── auth.ts       # Authentication endpoints
│   │   ├── users.ts      # User endpoints
│   │   └── {resource}.ts # Other resources
│   └── types/
│       ├── auth.types.ts # Auth type definitions
│       ├── user.types.ts # User type definitions
│       └── {resource}.types.ts
└── hooks/
    ├── useAuth.ts         # Auth hook
    ├── useUsers.ts        # Users hook
    └── use{Resource}.ts   # Other resources
```

**API Client Features:**
- Request interceptor (add auth token)
- Response interceptor (handle errors, refresh token)
- Centralized error handling
- TypeScript type safety
- Retry mechanism for failed requests

**8. Implement Authentication Integration**

Set up authentication flow:

**Authentication Structure:**
```
src/context/
└── AuthContext.tsx       # Auth state management

src/hooks/
└── useAuth.ts           # Auth operations hook

src/components/
└── ProtectedRoute.tsx   # Route guard component
```

**Authentication Features:**
- Secure token storage (httpOnly cookies preferred, or secure localStorage)
- Automatic token refresh
- Redirect on 401 (unauthorized)
- Loading states during auth
- Clear session on logout
- Protected route wrapper

**Security Requirements:**
- Never store sensitive data in localStorage if avoidable
- Use httpOnly cookies for tokens when possible
- Implement CSRF protection
- Clear all auth data on logout
- Handle token expiration gracefully

**9. Implement Data Fetching Integration**

Connect APIs to UI components based on chosen strategy:

**SSR (Server Components):**
```typescript
// app/users/page.tsx
async function UsersPage() {
  // Fetch data server-side
  const users = await fetchUsers()

  // Handle errors with error.tsx
  // Handle loading with loading.tsx

  return <UserList users={users} />
}
```

**CSR with React Query:**
```typescript
// components/UserList.tsx
'use client'

function UserList() {
  const { data, isLoading, error } = useUsers()

  if (isLoading) return <UsersSkeleton />
  if (error) return <ErrorMessage error={error} />

  return <div>{/* Render users */}</div>
}
```

**SSG/ISR:**
```typescript
// app/posts/[id]/page.tsx
export const revalidate = 3600 // Revalidate every hour (ISR)

async function PostPage({ params }: { params: { id: string } }) {
  const post = await fetchPost(params.id)
  return <Post data={post} />
}

// For SSG, generate static params
export async function generateStaticParams() {
  const posts = await fetchPosts()
  return posts.map(post => ({ id: post.id }))
}
```

**10. Implement Loading States**

Add loading states for all async operations:

**Loading State Patterns:**
- Initial load: Skeleton UI
- Pagination: Show existing + loading indicator
- Mutations: Disable UI + show spinner
- Background refresh: Subtle indicator
- Optimistic updates: Update UI immediately, rollback on error

**Example Loading States:**
```typescript
// Skeleton for initial load
{isLoading && <UsersSkeleton />}

// Loading indicator for mutations
<button disabled={isSubmitting}>
  {isSubmitting ? <Spinner /> : 'Save'}
</button>

// Optimistic update
const mutation = useMutation({
  mutationFn: updateUser,
  onMutate: async (newData) => {
    // Update UI optimistically
    queryClient.setQueryData(['user'], newData)
  },
  onError: (err, variables, context) => {
    // Rollback on error
    queryClient.setQueryData(['user'], context.previousData)
  }
})
```

**11. Implement Error Handling**

Handle all error scenarios comprehensively:

**Error Types and Handling:**
- **Network errors** → Retry mechanism with exponential backoff
- **400 (Validation)** → Show field-specific errors
- **401 (Unauthorized)** → Redirect to login, clear session
- **403 (Forbidden)** → Show permission denied message
- **404 (Not Found)** → Show not found message
- **500 (Server Error)** → Show error message + retry option
- **Timeout** → Show timeout message + retry option

**Error Handling Structure:**
```typescript
// Centralized error handler
function handleApiError(error: ApiError) {
  if (error.isNetworkError) {
    return retry(originalRequest)
  }

  switch (error.status) {
    case 400:
      return showValidationErrors(error.data)
    case 401:
      clearAuth()
      redirectToLogin()
      break
    case 403:
      showErrorToast('Permission denied')
      break
    case 404:
      showErrorToast('Resource not found')
      break
    case 500:
      showErrorToast('Server error. Please try again.')
      break
    default:
      showErrorToast('Something went wrong')
  }
}
```

**12. Implement Caching Strategy**

Choose appropriate caching based on data volatility:

**Caching Strategies:**
- **Static data** (rarely changes): Long cache time (1 hour+)
- **Semi-static** (changes occasionally): Stale-while-revalidate (5-30 min)
- **Dynamic data** (changes frequently): Short cache or no cache
- **Real-time data** (must be fresh): No cache, use websockets/polling

**React Query Caching Example:**
```typescript
const { data } = useQuery({
  queryKey: ['users'],
  queryFn: fetchUsers,
  staleTime: 5 * 60 * 1000, // 5 minutes
  cacheTime: 10 * 60 * 1000, // 10 minutes
  refetchOnWindowFocus: true,
  refetchOnReconnect: true,
})
```

**Cache Invalidation:**
```typescript
// After mutation, invalidate related queries
const mutation = useMutation({
  mutationFn: createUser,
  onSuccess: () => {
    queryClient.invalidateQueries(['users'])
  }
})
```

### Phase 4: Integration Testing

**13. Monitor Network Requests**

Use Chrome DevTools MCP to validate integration:

**Network Monitoring:**
```
mcp__chrome-devtools__navigate_page - Navigate to page
mcp__chrome-devtools__list_network_requests - Check all requests
mcp__chrome-devtools__get_network_request - Inspect specific requests
```

**What to verify:**
- Correct endpoints called
- Request headers include auth token
- Request payload is correct
- Response data is valid
- Response times acceptable (<200ms)
- No unnecessary duplicate requests
- Proper caching headers

**14. Verify Data Flow**

Test complete data flow from API to UI:

**Data Flow Validation:**
- [ ] Data fetches correctly
- [ ] Data displays in UI correctly
- [ ] Updates save successfully
- [ ] Updates reflect in UI immediately (optimistic updates)
- [ ] Cache works as expected
- [ ] Stale data revalidates properly

**15. Test Loading States**

Verify all loading states work correctly:

**Loading States Testing:**
- [ ] Initial load shows skeleton UI
- [ ] Mutations show loading indicators
- [ ] Buttons disable during submission
- [ ] Background refresh is subtle
- [ ] Optimistic updates work correctly
- [ ] Multiple simultaneous requests handled

**16. Test Error Scenarios**

Systematically test all error paths:

**Error Scenario Testing:**
```
Use Chrome DevTools to simulate:
- Network failure (disconnect network)
- Slow network (throttle to 3G)
- API errors (modify response)
- Invalid data (send malformed request)
- Unauthorized (use invalid token)
```

**Error Testing Checklist:**
- [ ] Network failure shows error + retry
- [ ] Retry mechanism works
- [ ] Validation errors display clearly
- [ ] Auth errors redirect to login
- [ ] Not found shows appropriate message
- [ ] Server errors show error + retry
- [ ] Error boundaries catch unexpected errors
- [ ] Error logging works (not exposed to user)

**17. Console Error Checking**

Use Chrome DevTools MCP to check for errors:
```
mcp__chrome-devtools__list_console_messages - Get all console messages
```

**Console Validation:**
- [ ] No JavaScript errors
- [ ] No unhandled promise rejections
- [ ] No network errors (or properly handled)
- [ ] No React warnings
- [ ] No prop-type warnings
- [ ] Debug logs removed (or conditional)

**18. Test Authentication Flow**

Verify complete authentication flow:

**Authentication Testing:**
- [ ] Login flow works end-to-end
- [ ] Token stored securely
- [ ] Token included in API requests
- [ ] Token refresh works automatically
- [ ] Logout clears session completely
- [ ] Protected routes redirect when not authenticated
- [ ] Session persists on page refresh
- [ ] Session expires appropriately

### Phase 5: Performance Optimization

**19. Optimize API Calls**

Ensure efficient API usage:

**API Call Optimization:**
- [ ] Eliminate unnecessary API calls
- [ ] Implement request deduplication
- [ ] Use proper caching strategy
- [ ] Implement pagination for large datasets
- [ ] Use field selection (only fetch needed data)
- [ ] Batch requests where possible
- [ ] Use GraphQL for complex queries (if applicable)

**20. Optimize Bundle Size**

Keep API client lightweight:

**Bundle Optimization:**
- [ ] Tree-shakeable API client
- [ ] Heavy dependencies lazy-loaded
- [ ] Proper code splitting
- [ ] No unused dependencies
- [ ] Types not included in bundle

**21. Optimize Rendering**

Prevent unnecessary re-renders:

**Render Optimization:**
- [ ] No render loops from API calls
- [ ] Expensive computations memoized
- [ ] Large lists virtualized (if needed)
- [ ] Proper dependency arrays in hooks
- [ ] React.memo for expensive components

**Performance Testing:**
```
Use Chrome DevTools MCP:
mcp__chrome-devtools__performance_start_trace - Start recording
mcp__chrome-devtools__performance_stop_trace - Stop recording
mcp__chrome-devtools__performance_analyze_insight - Analyze
```

**Performance Targets:**
- API response time: <200ms
- Time to Interactive: <3s
- First Contentful Paint: <1.5s
- No memory leaks
- Smooth 60fps interactions

### Phase 6: Security Audit

**22. Authentication Security**

Verify authentication is secure:

**Authentication Security Checklist:**
- [ ] Tokens stored securely (httpOnly cookies preferred)
- [ ] HTTPS enforced for all requests
- [ ] Token refresh implemented correctly
- [ ] Logout clears all sensitive data
- [ ] Session timeout appropriate (not too long)
- [ ] CSRF protection enabled
- [ ] XSS prevention (React handles most)

**23. Data Security**

Ensure data is handled securely:

**Data Security Checklist:**
- [ ] No sensitive data in URLs
- [ ] No sensitive data in console logs
- [ ] No API keys in client code
- [ ] Environment variables for secrets
- [ ] Input validation on all forms
- [ ] Output sanitization (prevent XSS)
- [ ] SQL injection not possible (backend responsibility)

**24. API Security**

Validate API integration security:

**API Security Checklist:**
- [ ] All requests over HTTPS
- [ ] Auth token in header (not URL)
- [ ] Rate limiting respected
- [ ] CORS configured correctly (backend)
- [ ] No sensitive data exposed in errors
- [ ] Stack traces not shown to users
- [ ] Error logging doesn't include sensitive data

**25. Dependency Security**

Check for vulnerabilities:

**Dependency Security:**
- [ ] No known vulnerabilities (`npm audit`)
- [ ] Dependencies up to date
- [ ] Security headers configured
- [ ] Content Security Policy set
- [ ] Only trusted libraries used

### Phase 7: Documentation & Finalization

**26. Create Integration Documentation**

Document the integration comprehensively:

```markdown
# API Integration Documentation

## Overview
{Brief description of what was integrated}

## Architecture
- Authentication: {JWT/OAuth/API Keys}
- Data Fetching: {SSR/CSR/SSG/ISR}
- Caching: {Strategy}
- Error Handling: {Approach}

## Endpoints Integrated
{List all endpoints with purpose}

## API Client
- Location: `src/lib/api-client.ts`
- Usage: {Brief example}

## Authentication
- How it works: {Explanation}
- Token storage: {Method}
- Token refresh: {Automatic/Manual}

## Error Handling
- Network errors: {How handled}
- API errors: {How handled}
- Validation errors: {How handled}

## Caching Strategy
{Explain caching approach}

## Known Issues
{List any known issues or limitations}

## Future Improvements
{List potential improvements}
```

**27. Set Up Monitoring**

Configure error tracking and monitoring:

**Monitoring Setup:**
- Error tracking (Sentry, Bugsnag, etc.)
- Performance monitoring (Vercel Analytics, etc.)
- API call logging
- User analytics tracking
- Source maps configured for debugging

**28. Create Completion Report**

Summarize the integration:

```markdown
# API Integration Completion Report

## Summary
- Component: {NAME}
- Endpoints: {COUNT}
- Tests Passed: {COUNT}/{TOTAL}
- Performance: ✅ All < 200ms
- Security: ✅ Audit passed

## Completed Tasks
- [x] API discovery and planning
- [x] Postman testing (all endpoints)
- [x] Frontend integration
- [x] Loading states implemented
- [x] Error handling comprehensive
- [x] Integration testing passed
- [x] Performance optimized
- [x] Security audit passed
- [x] Documentation complete
- [x] Monitoring configured

## Endpoints Integrated
{List with status}

## Performance Metrics
- Average response time: {TIME}ms
- Time to Interactive: {TIME}s
- First Contentful Paint: {TIME}s

## Security
- Authentication: ✅ Secure
- Data handling: ✅ Secure
- Dependencies: ✅ No vulnerabilities

## Production Readiness
✅ Ready for production deployment
```

## Integration Checklists

### Quick Integration Checklist

Use for rapid validation:
- [ ] API endpoints tested with Postman
- [ ] Authentication working
- [ ] Data fetches correctly
- [ ] Data displays in UI
- [ ] Loading states present
- [ ] Error handling works
- [ ] No console errors
- [ ] Performance acceptable
- [ ] Security validated

### Comprehensive Integration Checklist

Use for thorough validation:

**API Testing:**
- [ ] All endpoints tested with Postman
- [ ] All success scenarios validated
- [ ] All error scenarios validated
- [ ] Performance meets targets
- [ ] Response schemas validated

**Frontend Integration:**
- [ ] API client configured correctly
- [ ] Authentication implemented
- [ ] All endpoints integrated
- [ ] TypeScript types defined
- [ ] Proper error handling

**Loading States:**
- [ ] Initial load skeleton
- [ ] Mutation loading indicators
- [ ] Background refresh indicators
- [ ] Optimistic updates

**Error Handling:**
- [ ] Network errors handled
- [ ] Validation errors displayed
- [ ] Auth errors redirect
- [ ] Not found handled
- [ ] Server errors handled
- [ ] Retry mechanisms work

**Testing:**
- [ ] Happy path tested
- [ ] Error scenarios tested
- [ ] Authentication flow tested
- [ ] Performance tested
- [ ] No console errors

**Security:**
- [ ] Tokens stored securely
- [ ] HTTPS enforced
- [ ] No sensitive data exposed
- [ ] Input validation present
- [ ] CSRF protection enabled

**Performance:**
- [ ] API calls optimized
- [ ] Proper caching implemented
- [ ] No unnecessary re-renders
- [ ] Bundle size acceptable

**Documentation:**
- [ ] Integration documented
- [ ] API client usage documented
- [ ] Error handling documented
- [ ] Known issues documented

## MCP Server Usage

### Postman MCP (API Testing)
Essential for validating APIs before integration:
- Create test collections for all endpoints
- Test authentication flow
- Validate all CRUD operations
- Test error scenarios
- Validate response schemas
- Check performance
- Generate test reports

### Chrome DevTools MCP (Integration Testing)
Essential for validating integration:
- Navigate to pages
- Monitor network requests
- Check console for errors
- Verify data flow
- Test performance
- Simulate network conditions
- Test responsive behavior

### Serena MCP (Codebase Analysis)
Essential for understanding patterns:
- Find existing API patterns
- Locate API client utilities
- Understand context usage
- Find similar integrations
- Analyze error handling patterns

### Context7 MCP (Best Practices)
Essential for staying current:
- Next.js 14 data fetching patterns
- React Query/SWR best practices
- API client patterns
- Authentication strategies
- Error handling approaches

## Best Practices

### API Client Design
- Use singleton pattern for API client
- Implement request/response interceptors
- Centralize error handling
- Ensure type safety with TypeScript
- Implement retry mechanism
- Add request/response logging (dev only)

### Authentication
- Store tokens securely (httpOnly cookies > localStorage)
- Implement automatic token refresh
- Clear all auth data on logout
- Handle 401 gracefully (redirect to login)
- Never store sensitive data in localStorage
- Use secure random tokens
- Implement session timeout

### Data Fetching
- Choose appropriate strategy (SSR/CSR/SSG/ISR)
- Implement proper caching
- Use React Query or SWR for client-side
- Add loading states for all async operations
- Handle all error scenarios
- Implement optimistic updates where appropriate

### Error Handling
- Differentiate error types (network, validation, auth, server)
- Provide clear, actionable error messages
- Implement retry mechanisms for transient errors
- Log errors for monitoring (not to console in production)
- Never expose sensitive information in errors
- Use error boundaries for unexpected errors

### Performance
- Cache aggressively (but invalidate correctly)
- Minimize API calls
- Implement pagination for large datasets
- Use optimistic updates where appropriate
- Lazy load heavy dependencies
- Implement request deduplication
- Use proper React Query/SWR configuration

### Security
- Always use HTTPS
- Store tokens securely
- Implement CSRF protection
- Validate all user input
- Sanitize all output
- Don't expose sensitive data in URLs
- Use environment variables for secrets
- Keep dependencies updated
- Run security audits regularly

## Troubleshooting

### API Calls Failing
```
Check with Chrome DevTools MCP:
1. Network tab → Is request reaching server?
2. Check status code and response
3. Verify auth token is included
4. Check request headers
5. Verify API endpoint URL is correct
6. Check CORS headers (backend issue)
7. Look for console errors
```

### Authentication Not Working
```
Debug steps:
1. Check token is being stored
2. Verify token is included in requests
3. Check token format (Bearer {token})
4. Verify token hasn't expired
5. Test token refresh flow
6. Check API authentication endpoint
7. Verify CORS allows credentials
```

### Data Not Displaying
```
Debug steps:
1. Check API returns data (Network tab)
2. Verify data structure matches types
3. Check React Query/SWR configuration
4. Look for console errors
5. Verify state updates correctly
6. Check component re-rendering
7. Verify data transformations
```

### Performance Issues
```
Analyze with Chrome DevTools MCP:
1. Check API response times
2. Look for unnecessary requests
3. Check for render loops
4. Verify caching is working
5. Profile with React DevTools
6. Check bundle size
7. Look for memory leaks
```

### Console Errors
```
Use Chrome DevTools MCP:
1. List all console messages
2. Identify error source
3. Check stack trace
4. Fix error at source
5. Verify no warnings remain
6. Test error scenarios
```

## Completion Criteria

The API integration task is complete when:

1. **All APIs tested with Postman:**
   - All endpoints validated
   - All scenarios tested
   - Test report generated

2. **Frontend integration complete:**
   - API client configured
   - Authentication working
   - All endpoints integrated
   - TypeScript types defined

3. **User experience polished:**
   - Loading states implemented
   - Error handling comprehensive
   - Optimistic updates working
   - No jarring transitions

4. **Quality validated:**
   - No console errors
   - All network requests successful
   - Performance meets targets
   - Security audit passed

5. **Production ready:**
   - Documentation complete
   - Monitoring configured
   - Error tracking set up
   - Team trained

## Integration with Other Skills

### Complete Development Workflow

This skill fits into the complete workflow:

1. **ui-developer** → Build UI from Figma designs
2. **api-integrator** → Connect UI to backend APIs (THIS SKILL)
3. **ui-tester** → Test complete functionality
4. **code-reviewer** → Review quality before production

### Workflow Integration

API integrator ensures:
- APIs validated before integration (Postman testing)
- Integration follows best practices
- Complete error handling
- Performance optimized
- Security validated
- Production ready

## Final Production Readiness

API integration is production-ready when:
- [ ] All Postman tests passing
- [ ] All endpoints integrated
- [ ] Authentication working securely
- [ ] Loading states polished
- [ ] Error handling comprehensive
- [ ] Performance targets met (<200ms API calls)
- [ ] Security audit passed
- [ ] No console errors
- [ ] Documentation complete
- [ ] Monitoring configured
- [ ] Team trained on new integration
- [ ] Rollback plan ready
