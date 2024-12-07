#include <bits/stdc++.h>
using namespace std;
//{{{
using ll = long long;
ll INF = 2e18;

// Vector
template <typename T> using vc = vector<T>;
template <typename T> using vv = vc<vc<T>>;
using vl = vc<ll>;      // vector<ll>
using vvl = vv<ll>;     // vector<vector<ll>>
using vvvl = vv<vl>;    // vector<vector<vector<ll>>>
using vvvvl = vv<vvl>;  // vector<vector<vector<vector<ll>>>>
using vs = vc<string>;  // vector<string>
using vvs = vv<string>; // vector<vector<string>>

// CE when using brace([]) access in vector
#ifdef ONLINE_JUDGE
#define _GLIBCXX_DEBUG
#define _LIBCPP_DEBUG 0
#endif

#define OVERLOAD_REP(_1, _2, _3, name, ...) name
#define REP1(i, n) for (auto i = std::decay_t<decltype(n)>{}; (i) != (n); ++(i))
#define REP2(i, l, r) for (auto i = (l); (i) != (r); ++(i))
#define rep(...) OVERLOAD_REP(__VA_ARGS__, REP2, REP1)(__VA_ARGS__)

#define all(...) std::begin(__VA_ARGS__), std::end(__VA_ARGS__)
#define rall(...) std::rbegin(__VA_ARGS__), std::rend(__VA_ARGS__)

#define Yes cout << "Yes" << '\n'
#define No cout << "No" << '\n'
// if (a == b) YN;
#define YN                                                                     \
  { cout << "Yes" << "\n"; }                                                   \
  else {                                                                       \
    cout << "No" << "\n";                                                      \
  }

#define chmax(x, y) x = max(x, y)
#define chmin(x, y) x = min(x, y)

// Grid
// [0] = r [1] = d [2] = l [3] = u
vl dx = {1, 0, -1, 0};
vl dy = {0, 1, 0, -1};

// Trueの時にContinue
bool out_grid(ll i, ll j, ll h, ll w) {
  return (!(0 <= i && i < h && 0 <= j && j < w));
}

// nC_2, nC_3
ll nc2(ll x) { return x * (x - 1) / 2; }
ll nc3(ll x) { return x * (x - 1) * (x - 2) / 6; }

#define debug(x) cerr << #x << " = " << x << '\n'

// cin >> a; for vector!
template <class T> istream &operator>>(istream &i, vc<T> &v) {
  rep(j, size(v)) i >> v[j];
  return i;
}
//  }}}

int main() {
  // Code here:
  return 0;
}

// vim: foldmethod=marker foldlevel=0
